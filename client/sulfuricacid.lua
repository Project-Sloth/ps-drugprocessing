local spawnedSulfuricAcidBarrels = 0
local SulfuricAcidBarrels = {}
local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.SulfuricAcidFarm.coords, true) < 50 then
			SpawnSulfuricAcidBarrels()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("ps-drugprocessing:pickSulfuric")
AddEventHandler("ps-drugprocessing:pickSulfuric", function()
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #SulfuricAcidBarrels, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(SulfuricAcidBarrels[i]), false) < 1 then
				nearbyObject, nearbyID = SulfuricAcidBarrels[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

				QBCore.Functions.Progressbar("search_register", "Picking up sulfuric acid ...", 10000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					SetEntityAsMissionEntity(nearbyObject, false, true)
					DeleteObject(nearbyObject)

					table.remove(SulfuricAcidBarrels, nearbyID)
					spawnedSulfuricAcidBarrels = spawnedSulfuricAcidBarrels - 1
	
					TriggerServerEvent('ps-drugprocessing:pickedUpSulfuricAcid')

				end, function()
					ClearPedTasks(PlayerPedId())
				end)

				isPickingUp = false
			end
		else
			Citizen.Wait(500)
		end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(SulfuricAcidBarrels) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

function SpawnSulfuricAcidBarrels()
	while spawnedSulfuricAcidBarrels < 10 do
		Citizen.Wait(0)
		local weedCoords = GenerateSulfuricAcidCoords()
		RequestModel(`mw_sulfuric_barrel`)
		while not HasModelLoaded(`mw_sulfuric_barrel`) do
			Wait(100)
		end
		local obj = CreateObject(`mw_sulfuric_barrel`, weedCoords.x, weedCoords.y, weedCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(SulfuricAcidBarrels, obj)
		spawnedSulfuricAcidBarrels = spawnedSulfuricAcidBarrels + 1
	end
end

function ValidateSulfuricAcidCoord(plantCoord)
	if spawnedSulfuricAcidBarrels > 0 then
		local validate = true

		for k, v in pairs(SulfuricAcidBarrels) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.SodiumHydroxideFarm.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateSulfuricAcidCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-7, 7)

		Citizen.Wait(100)

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

function GetCoordZSulfuricAcid(x, y)
	local groundCheckHeights = { 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 150.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 18.31
end
