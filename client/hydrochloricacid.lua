local spawnedHydrochloricAcidBarrels = 0
local HydrochloricAcidBarrels = {}
local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HydrochloricAcidFarm.coords, true) < 50 then
			SpawnHydrochloricAcidBarrels()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent("ps-drugprocessing:client:hydrochloricacid")
AddEventHandler("ps-drugprocessing:client:hydrochloricacid", function()
	
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #HydrochloricAcidBarrels, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(HydrochloricAcidBarrels[i]), false) < 1 then
				nearbyObject, nearbyID = HydrochloricAcidBarrels[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

				QBCore.Functions.Progressbar("search_register", "Picking up hydrochloric acid..", 10000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function()
					ClearPedTasks(PlayerPedId())
					SetEntityAsMissionEntity(nearbyObject, false, true)
					DeleteObject(nearbyObject)

					table.remove(HydrochloricAcidBarrels, nearbyID)
					spawnedHydrochloricAcidBarrels = spawnedHydrochloricAcidBarrels - 1
	
					TriggerServerEvent('ps-drugprocessing:pickedUpHydrochloricAcid')

				end, function()
					ClearPedTasks(PlayerPedId())
				end)

				isPickingUp = false
		else
			Citizen.Wait(500)
		end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(HydrochloricAcidBarrels) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

function SpawnHydrochloricAcidBarrels()
	while spawnedHydrochloricAcidBarrels < 5 do
		Citizen.Wait(0)
		local weedCoords = GenerateHydrochloricAcidCoords()
		RequestModel(`mw_hydro_barrel`)
		while not HasModelLoaded(`mw_hydro_barrel`) do
			Wait(100)
		end
		local obj = CreateObject(`mw_hydro_barrel`, weedCoords.x, weedCoords.y, weedCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(HydrochloricAcidBarrels, obj)
		spawnedHydrochloricAcidBarrels = spawnedHydrochloricAcidBarrels + 1
	end
end

function ValidateHydrochloricAcidCoord(plantCoord)
	if spawnedHydrochloricAcidBarrels > 0 then
		local validate = true

		for k, v in pairs(HydrochloricAcidBarrels) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.HydrochloricAcidFarm.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateHydrochloricAcidCoords()
	while true do
		Citizen.Wait(1)

		local weed2CoordX, weed2CoordY

		math.randomseed(GetGameTimer())
		local modX2 = math.random(-15, 15)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY2 = math.random(-15, 15)

		weed2CoordX = Config.CircleZones.HydrochloricAcidFarm.coords.x + modX2
		weed2CoordY = Config.CircleZones.HydrochloricAcidFarm.coords.y + modY2

		local coordZ2 = GetCoordZHydrochloricAcid(weed2CoordX, weed2CoordY)
		local coord2 = vector3(weed2CoordX, weed2CoordY, coordZ2)

		if ValidateHydrochloricAcidCoord(coord2) then
			return coord2
		end
	end
end

function GetCoordZHydrochloricAcid(x, y)
	local groundCheckHeights = { 20.0, 21.0, 22.0, 23.0, 24.0, 175.0, 190.0, 200.0, 205.0, 215.0, 225.0 }

	for i, height in ipairs(groundCheckHeights) do
		local found2Ground, z = GetGroundZFor_3dCoord(x, y, height)

		if found2Ground then
			return z
		end
	end

	return 24.5
end
