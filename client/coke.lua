local QBCore = exports['qb-core']:GetCoreObject()
local spawnedCocaLeaf = 0
local CocaPlants = {}
local isPickingUp, isProcessing, inCokeField = false, false, false

local function LoadAnimationDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end

local function OpenDoorAnimation()
    local ped = PlayerPedId()
    LoadAnimationDict("anim@heists@keycard@") 
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(400)
    ClearPedTasks(ped)
end

local function EnterCWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    CWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.CokeLab["exit"].coords.x, Config.CokeLab["exit"].coords.y, Config.CokeLab["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.CokeLab["exit"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
end

local function ExitCWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    CWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.CokeLab["enter"].coords.x, Config.CokeLab["enter"].coords.y, Config.CokeLab["enter"].coords.z - 0.98)
    SetEntityHeading(ped, Config.CokeLab["enter"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
	CWarehouse = false
end

local function ProcessCoke()
	isProcessing = true
	local playerPed = PlayerPedId()
	
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processCocaLeaf')

		local timeLeft = Config.Delays.CokeProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1

			if #(GetEntityCoords(playerPed)-Config.CircleZones.CokeProcessing.coords) > 4 then
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


local function ValidateCocaLeafCoord(plantCoord)
	local validate = true
	if spawnedCocaLeaf > 0 then
		for k, v in pairs(CocaPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inCokeField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZCoke(x, y)
	local groundCheckHeights = { 1.0, 25.0, 50.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 77
end

local function GenerateCocaLeafCoords()
	while true do
		Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)

		weedCoordX = Config.CircleZones.CokeField.coords.x + modX
		weedCoordY = Config.CircleZones.CokeField.coords.y + modY

		local coordZ = GetCoordZCoke(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateCocaLeafCoord(coord) then
			return coord
		end
	end
end

local function SpawnCocaPlants()
	while spawnedCocaLeaf < 15 do
		Wait(0)
		local weedCoords = GenerateCocaLeafCoords()
		RequestModel(`mw_coke_plant`)
		while not HasModelLoaded(`mw_coke_plant`) do
			Wait(100)
		end
		local obj = CreateObject(`mw_coke_plant`, weedCoords.x, weedCoords.y, weedCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(CocaPlants, obj)
		spawnedCocaLeaf += 1
	end
end


local function CutCokePowder()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processCocaPowder')

		local timeLeft = Config.Delays.CokeProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1

			if #(GetEntityCoords(playerPed)-Config.CircleZones.CokeProcessing.coords) > 4 then
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

local function ProcessBricks()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.packing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processCocaBrick')

		local timeLeft = Config.Delays.CokeProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1

			if #(GetEntityCoords(playerPed)-Config.CircleZones.CokeBrick.coords) > 4 then
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

RegisterNetEvent('ps-drugprocessing:ProcessCocaFarm', function()
	local coords = GetEntityCoords(PlayerPedId())

	if #(coords-Config.CircleZones.CokeProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					ProcessCoke()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {coca_leaf = Config.CokeProcessing.CokeLeaf, trimming_scissors = 1})
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ProcessCocaPowder', function()
	local coords = GetEntityCoords(PlayerPedId())
	local amount = 10
	local amount2 = 5
	
	if #(coords-Config.CircleZones.CokePowder.coords) < 5 then
		if not isProcessing then
			local check = {
				coke = Config.CokeProcessing.Coke,
				bakingsoda = Config.CokeProcessing.BakingSoda,
				finescale = 1
			}
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					CutCokePowder()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, check)
		else
			QBCore.Functions.Notify(Lang:t("error.already_processing"), 'error')
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ProcessBricks', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	local amount = 4
	
	if #(coords-Config.CircleZones.CokeBrick.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					ProcessBricks()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {coke_small_brick = Config.CokeProcessing.SmallBrick, finescale = 1})
		else
			QBCore.Functions.Notify(Lang:t("error.already_processing"), 'error')
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:EnterCWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.CokeLab["enter"].coords.x, Config.CokeLab["enter"].coords.y, Config.CokeLab["enter"].coords.z))
    if dist < 2 then
		QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
			if result.ret then
				EnterCWarehouse()
			else
				QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
			end
		end, {cocainekey=1})
	end
end)

RegisterNetEvent('ps-drugprocessing:ExitCWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.CokeLab["exit"].coords.x, Config.CokeLab["exit"].coords.y, Config.CokeLab["exit"].coords.z))
    if dist < 2 then
		ExitCWarehouse()
	end
end)

RegisterNetEvent('ps-drugprocessing:pickCocaLeaves', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #CocaPlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(CocaPlants[i]), false) < 2 then
			nearbyObject, nearbyID = CocaPlants[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp then
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

				table.remove(CocaPlants, nearbyID)
				spawnedCocaLeaf = spawnedCocaLeaf - 1

				TriggerServerEvent('ps-drugprocessing:pickedUpCocaLeaf')
				isPickingUp = false
			end, function()
				ClearPedTasks(playerPed)
				isPickingUp = false
			end)
		end
	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(CocaPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

RegisterCommand('propfix', function()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end)

CreateThread(function()
	local cokeZone = CircleZone:Create(Config.CircleZones.CokeField.coords, 50.0, {
		name = "ps-cokezone",
		debugPoly = false
	})
	cokeZone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            inCokeField = true
            SpawnCocaPlants()
        else
            inCokeField = false
        end
    end)
end)
