local spawnedPoppys = 0
local PoppyPlants = {}
local isPickingUp, isProcessing = false, false
local QBCore = exports['qb-core']:GetCoreObject()


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinField.coords, true) < 50 then
			SpawnPoppyPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessHeroin()

	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing resin...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processPoppyResin')

		local timeLeft = Config.Delays.HeroinProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.HeroinProcessing.coords, false) > 4 then
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)

	isProcessing = false
end

RegisterNetEvent("ps-drugprocessing:pickHeroin")
AddEventHandler("ps-drugprocessing:pickHeroin", function()
	
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #PoppyPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(PoppyPlants[i]), false) < 1 then
				nearbyObject, nearbyID = PoppyPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

				QBCore.Functions.Progressbar("search_register", "Picking up poppy resin...", 10000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					SetEntityAsMissionEntity(nearbyObject, false, true)
					DeleteObject(nearbyObject)

					table.remove(PoppyPlants, nearbyID)
					spawnedPoppys = spawnedPoppys - 1
	
					TriggerServerEvent('ps-drugprocessing:pickedUpPoppy')

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
		for k, v in pairs(PoppyPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

function SpawnPoppyPlants()
	while spawnedPoppys < 15 do
		Citizen.Wait(0)
		local heroinCoords = GenerateHeroinCoords()
		RequestModel(`prop_plant_01b`)
		while not HasModelLoaded(`prop_plant_01b`) do
			Wait(100)
		end
		local obj = CreateObject(`prop_plant_01b`, heroinCoords.x, heroinCoords.y, heroinCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(PoppyPlants, obj)
		spawnedPoppys = spawnedPoppys + 1
	end
end

function ValidateHeroinCoord(plantCoord)
	if spawnedPoppys > 0 then
		local validate = true

		for k, v in pairs(PoppyPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.HeroinField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateHeroinCoords()
	while true do
		Citizen.Wait(1)

		local heroinCoordX, heroinCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-60, 60)

		Citizen.Wait(100)

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

function GetCoordZHeroin(x, y)
	local groundCheckHeights = { 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 50.0, 75.0, 100.0, 110.0, 125.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 12.64
end
