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
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinProcessing.coords, true) < 2 then
			if not isProcessing then
				local pos = GetEntityCoords(PlayerPedId())
				QBCore.Functions.DrawText3D(pos.x, pos.y, pos.z, "~g~E~w~ - Process poppy resin")
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					if result then
						ProcessHeroin()
					else
						QBCore.Functions.Notify('You lack poppy resin', 'error')
					end
				end, 'poppyresin')
			end
		else
			Citizen.Wait(500)
		end
	end
end)
]]

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
	TriggerServerEvent('qb-drugtrafficking:processPoppyResin')

		local timeLeft = Config.Delays.HeroinProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.HeroinProcessing.coords, false) > 4 then
				TriggerServerEvent('qb-drugtrafficking:cancelProcessing')
				break
			end
		end
		StopAnimTask(PlayerPedId())
	end, function()
		StopAnimTask(PlayerPedId())
	end)

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
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

			if not isPickingUp then
				QBCore.Functions.Draw2DText(0.5, 0.88, 'Press [~g~ E ~w~] to pickup poppy resin', 0.5)
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

				QBCore.Functions.Progressbar("search_register", "Picking up poppy resin...", 10000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					StopAnimTask(PlayerPedId())
					SetEntityAsMissionEntity(nearbyObject, false, true)
					DeleteObject(nearbyObject)

					table.remove(PoppyPlants, nearbyID)
					spawnedPoppys = spawnedPoppys - 1
	
					TriggerServerEvent('qb-drugtrafficking:pickedUpPoppy')

				end, function()
					StopAnimTask(PlayerPedId())
				end)

				isPickingUp = false
			end
		else
			Citizen.Wait(500)
		end
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
		RequestModel(`mw_heroin_plant`)
		while not HasModelLoaded(`mw_heroin_plant`) do
			Wait(100)
		end
		local obj = CreateObject(`mw_heroin_plant`, heroinCoords.x, heroinCoords.y, heroinCoords.z, true, true, false)
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
