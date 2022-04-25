local QBCore = exports['qb-core']:GetCoreObject()
local SpawnedChemicals = 0
local Chemicals = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.ChemicalsField.coords, true) < 50 then
			SpawnChemicals()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Chemicals) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

-- Chemical Menu Trigger & Menu Button Triggers --

RegisterNetEvent('ps-drugprocessing:chemicalmenu', function()
	createChemicalMenu()
	exports['qb-menu']:openMenu(chemMenu)
end)

function createChemicalMenu()
    chemMenu = {
        {
            isHeader = true,
            header = 'Chemical Menu'
        },
        {
            header = "Hydrochloric Acid",
            txt = "x1 Chemicals",
			params = {
                isServer = false,
                event = "ps-drugprocessing:hydrochloric_acid",
            }
        },
        {
            header = "Sodium Hydroxide",
            txt = "x1 Chemicals",
			params = {
                isServer = false,
                event = "ps-drugprocessing:sodium_hydroxide",
            }
        },
        {
            header = "Sulfuric Acid",
            txt = "x1 Chemicals",
			params = {
                isServer = false,
                event = "ps-drugprocessing:sulfuric_acid",
            }
        },
        {
			header = "LSA",
            txt = "x1 Chemicals",
			params = {
                isServer = false,
                event = "ps-drugprocessing:lsa",
            }
        },
        {
            header = "Close Menu",
			txt = "Close Menu",
			params = {
                isServer = false,
                event = exports['qb-menu']:closeMenu(),
            }
        },
    }
    exports['qb-menu']:openMenu(chemMenu)
end

--------------------------------------------------------------------

RegisterNetEvent("ps-drugprocessing:hydrochloric_acid")
AddEventHandler("ps-drugprocessing:hydrochloric_acid", function()
    ped = PlayerPedId();
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
	if result then
		process_hydrochloric_acid()
		else
			QBCore.Functions.Notify('You lack Chemicals', 'error')
		end
	end, 'chemicals')
end)

RegisterNetEvent("ps-drugprocessing:lsa")
AddEventHandler("ps-drugprocessing:lsa", function()
    ped = PlayerPedId();
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
	if result then
		process_lsa()
		else
			QBCore.Functions.Notify('You lack Chemicals', 'error')
		end
	end, 'chemicals')
end)

function process_lsa()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing ...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:process_lsa')

		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.ChemicalsConvertionMenu.coords, false) > 4 then
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

RegisterNetEvent("ps-drugprocessing:sulfuric_acid")
AddEventHandler("ps-drugprocessing:sulfuric_acid", function()
    ped = PlayerPedId();
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
	if result then
		process_sulfuric_acid()
		else
			QBCore.Functions.Notify('You lack Chemicals', 'error')
		end
	end, 'chemicals')
end)

RegisterNetEvent("ps-drugprocessing:sodium_hydroxide")
AddEventHandler("ps-drugprocessing:sodium_hydroxide", function()
    ped = PlayerPedId();
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
	if result then
		process_sodium_hydroxide()
		else
			QBCore.Functions.Notify('You lack Chemicals', 'error')
		end
	end, 'chemicals')
end)

function process_sulfuric_acid()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing ...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processprocess_sulfuric_acid')

		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.ChemicalsConvertionMenu.coords, false) > 4 then
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

function process_sodium_hydroxide()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing ...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processsodium_hydroxide')

		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.ChemicalsConvertionMenu.coords, false) > 4 then
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

function process_hydrochloric_acid()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing ...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processHydrochloric_acid')

		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.ChemicalsConvertionMenu.coords, false) > 4 then
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


RegisterNetEvent("ps-drugprocessing:pickChemicals")
AddEventHandler("ps-drugprocessing:pickChemicals", function()
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #Chemicals, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Chemicals[i]), false) < 1 then
				nearbyObject, nearbyID = Chemicals[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

				QBCore.Functions.Progressbar("search_register", "Picking up chemicals..", 10000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					SetEntityAsMissionEntity(nearbyObject, false, true)
					DeleteObject(nearbyObject)

					table.remove(Chemicals, nearbyID)
					SpawnedChemicals = SpawnedChemicals - 1
	
					TriggerServerEvent('ps-drugprocessing:pickedUpChemicals')

				end, function()
					ClearPedTasks(PlayerPedId())
				end)

				isPickingUp = false
		else
			Citizen.Wait(500)
		end
end)

function SpawnChemicals()
	while SpawnedChemicals < 10 do
		Citizen.Wait(0)
		local chemicalsCoords = GeneratechemicalsCoords()
		RequestModel(`mw_chemical_barrel`)
		while not HasModelLoaded(`mw_chemical_barrel`) do
			Wait(100)
		end
		local obj = CreateObject(`mw_chemical_barrel`, chemicalsCoords.x, chemicalsCoords.y, chemicalsCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(Chemicals, obj)
		SpawnedChemicals = SpawnedChemicals + 1
	end
end

function ValidatechemicalsCoord(plantCoord)
	if SpawnedChemicals > 0 then
		local validate = true

		for k, v in pairs(Chemicals) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.ChemicalsField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratechemicalsCoords()
	while true do
		Citizen.Wait(1)

		local chemicalsCoordX, chemicalsCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		chemicalsCoordX = Config.CircleZones.ChemicalsField.coords.x + modX
		chemicalsCoordY = Config.CircleZones.ChemicalsField.coords.y + modY

		local coordZ = GetCoordZChemicals(chemicalsCoordX, chemicalsCoordY)
		local coord = vector3(chemicalsCoordX, chemicalsCoordY, coordZ)

		if ValidatechemicalsCoord(coord) then
			return coord
		end
	end
end

function GetCoordZChemicals(x, y)
	local groundCheckHeights = { 1, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0, 315.0, 320.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 5.9
end
