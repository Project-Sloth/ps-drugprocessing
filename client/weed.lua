local spawnedWeeds = 0
local weedPlants = {}
local isPickingUp, isProcessing = false, false
local QBCore = exports['qb-core']:GetCoreObject()



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 50 then
			SpawnWeedPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessWeed()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Trimming weed...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processCannabis')

		local timeLeft = Config.Delays.WeedProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 4 then
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

RegisterNetEvent("ps-drugprocessing:processWeed")
AddEventHandler("ps-drugprocessing:processWeed",function()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			print('You have this item HA')
			ProcessWeed()
		else
			QBCore.Functions.Notify("You don't have any cannabis!", 'error')
		end
	end,'cannabis')
end)

RegisterNetEvent("ps-drugprocessing:pickWeed")
AddEventHandler("ps-drugprocessing:pickWeed", function()
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 1 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

				QBCore.Functions.Progressbar("search_register", "Uprooting weed plant...", 10000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					SetEntityAsMissionEntity(nearbyObject, false, true)
					DeleteObject(nearbyObject)

					table.remove(weedPlants, nearbyID)
					spawnedWeeds = spawnedWeeds - 1
	
					TriggerServerEvent('ps-drugprocessing:pickedUpCannabis')

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
		for k, v in pairs(weedPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

function SpawnWeedPlants()
	while spawnedWeeds < 15 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords()
		RequestModel(`mw_weed_plant`)
		while not HasModelLoaded(`mw_weed_plant`) do
			Wait(100)
		end
		local obj = CreateObject(`mw_weed_plant`, weedCoords.x, weedCoords.y, weedCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(weedPlants, obj)
		spawnedWeeds = spawnedWeeds + 1
	end
end

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZWeed(x, y)
	local groundCheckHeights = { 50, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 53.85
end

RegisterNetEvent('ps-drugprocessing:client:rollJoint')
AddEventHandler('ps-drugprocessing:client:rollJoint', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			RollJoint()
		else
			QBCore.Functions.Notify('You lack marijuana', 'error')
		end
	end, 'marijuana')
end)

function RollJoint()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Rolling a joint ...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:rollJoint')
	local timeLeft = Config.Delays.WeedProcessing / 1000

	while timeLeft > 0 do
		Citizen.Wait(1000)
	timeLeft = timeLeft - 1

	end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)
	isProcessing = false
end
