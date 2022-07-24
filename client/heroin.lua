local spawnedPoppys = 0
local PoppyPlants = {}
local isPickingUp, isProcessing, inHeroinField = false, false, false
local QBCore = exports['qb-core']:GetCoreObject()

local function ValidateHeroinCoord(plantCoord)
	local validate = true
	if spawnedPoppys > 0 then
		for k, v in pairs(PoppyPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inHeroinField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZHeroin(x, y)
	local groundCheckHeights = { 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 50.0, 75.0, 100.0, 110.0, 125.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 12.64
end

local function GenerateHeroinCoords()
	while true do
		Wait(1)

		local heroinCoordX, heroinCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-60, 60)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-60, 60)

		heroinCoordX = Config.CircleZones.HeroinField.coords.x + modX
		heroinCoordY = Config.CircleZones.HeroinField.coords.y + modY

		local coordZ = GetCoordZHeroin(heroinCoordX, heroinCoordY)
		local coord = vector3(heroinCoordX, heroinCoordY, coordZ)

		if ValidateHeroinCoord(coord) then
			return coord
		end
	end
end

local function SpawnPoppyPlants()
	while spawnedPoppys < 15 do
		Wait(0)
		local heroinCoords = GenerateHeroinCoords()
		RequestModel(`prop_plant_01b`)
		while not HasModelLoaded(`prop_plant_01b`) do
			Wait(100)
		end
		local obj = CreateObject(`prop_plant_01b`, heroinCoords.x, heroinCoords.y, heroinCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(PoppyPlants, obj)
		spawnedPoppys += 1
	end
end

local function ProcessHeroin()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processPoppyResin')

		local timeLeft = Config.Delays.HeroinProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1

			if #(GetEntityCoords(playerPed)-Config.CircleZones.HeroinProcessing.coords) > 4 then
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

RegisterNetEvent('ps-drugprocessing:ProcessPoppy', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if #(coords-Config.CircleZones.HeroinProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					ProcessHeroin()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {poppyresin = Config.HeroinProcessing.Poppy})
		end
	end
end)

RegisterNetEvent("ps-drugprocessing:processHeroin",function()
	QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result.ret then
			ProcessHeroin()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end, {poppyresin = Config.HeroinProcessing.Poppy})
end)


RegisterNetEvent("ps-drugprocessing:pickHeroin", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #PoppyPlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(PoppyPlants[i]), false) < 2 then
			nearbyObject, nearbyID = PoppyPlants[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		isPickingUp = true
		TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
		QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.collecting"), 10000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			ClearPedTasks(playerPed)
			SetEntityAsMissionEntity(nearbyObject, false, true)
			DeleteObject(nearbyObject)

			table.remove(PoppyPlants, nearbyID)
			spawnedPoppys -= 1

			TriggerServerEvent('ps-drugprocessing:pickedUpPoppy')
			isPickingUp = false

		end, function()
			ClearPedTasks(playerPed)
			isPickingUp = false
		end)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(PoppyPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

CreateThread(function()
	local heroinZone = CircleZone:Create(Config.CircleZones.HeroinField.coords, 50.0, {
		name = "ps-heroinzone",
		debugPoly = false
	})
	heroinZone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            inHeroinField = true
            SpawnPoppyPlants()
        else
            inHeroinField = false
        end
    end)
end)