local spawnedSulfuricAcidBarrels = 0
local SulfuricAcidBarrels = {}
local inSulfuricFarm = false
local QBCore = exports['qb-core']:GetCoreObject()

local function ValidateSulfuricAcidCoord(plantCoord)
	local validate = true
	if spawnedSulfuricAcidBarrels > 0 then
		for _, v in pairs(SulfuricAcidBarrels) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inSulfuricFarm then
			validate2 = false
		end
	end
	return validate
end

local function GetCoordZSulfuricAcid(x, y)
	local groundCheckHeights = { 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 150.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 18.31
end

local function GenerateSulfuricAcidCoords()
	while true do
		Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-7, 7)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-7, 7)

		weedCoordX = Config.CircleZones.SulfuricAcidFarm.coords.x + modX
		weedCoordY = Config.CircleZones.SulfuricAcidFarm.coords.y + modY

		local coordZ = GetCoordZSulfuricAcid(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateSulfuricAcidCoord(coord) then
			return coord
		end
	end
end

local function SpawnSulfuricAcidBarrels()
	local model = `mw_sulfuric_barrel`
	while spawnedSulfuricAcidBarrels < 10 do
		Wait(0)
		local weedCoords = GenerateSulfuricAcidCoords()
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(100)
		end
		local obj = CreateObject(model, weedCoords.x, weedCoords.y, weedCoords.z, false, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(SulfuricAcidBarrels, obj)
		spawnedSulfuricAcidBarrels += 1
	end
	SetModelAsNoLongerNeeded(model)
end


RegisterNetEvent("ps-drugprocessing:pickSulfuric", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #SulfuricAcidBarrels, 1 do
		if #(coords - GetEntityCoords(SulfuricAcidBarrels[i])) < 2 then
			nearbyObject, nearbyID = SulfuricAcidBarrels[i], i
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
				ClearPedTasks(PlayerPedId())
				SetEntityAsMissionEntity(nearbyObject, false, true)
				DeleteObject(nearbyObject)
				table.remove(SulfuricAcidBarrels, nearbyID)
				spawnedSulfuricAcidBarrels -= 1
				TriggerServerEvent('ps-drugprocessing:pickedUpSulfuricAcid')
				isPickingUp = false
			end, function()
				ClearPedTasks(PlayerPedId())
				isPickingUp = false
			end)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(SulfuricAcidBarrels) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

CreateThread(function()
	local sulfuricZone = CircleZone:Create(Config.CircleZones.SulfuricAcidFarm.coords, 50.0, {
		name = "ps-sulfuriczone",
		debugPoly = false
	})
	sulfuricZone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            inSulfuricFarm = true
            SpawnSulfuricAcidBarrels()
        else
            inSulfuricFarm = false
        end
    end)
end)
