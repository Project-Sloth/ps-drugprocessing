local  isProcessing, isTempChangeU, isTempChangeD, isBagging, hasitem1, hasitem2 = false, false, false, false, false, false
local Methlab = false
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ps-drugprocessing:ProcessChemicals')
AddEventHandler('ps-drugprocessing:ProcessChemicals', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if GetDistanceBetweenCoords(coords, Config.CircleZones.MethProcessing.coords, true) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result then
					print('You have this item SA')
					hasitem1 = true
				else
					QBCore.Functions.Notify('You lack some of the required items - Hydrochloric Acid, Sulfuric Acid or Sodium Hydroxide', 'error')
				end
			end, 'sulfuric_acid')
			Citizen.Wait(1000) -- BUFFER
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result and hasitem1 then
					print('You have this item HA')
					hasitem2 = true
				else
					QBCore.Functions.Notify('You lack some of the required items - Hydrochloric Acid, Sulfuric Acid or Sodium Hydroxide', 'error')
				end
			end, 'hydrochloric_acid')
			Citizen.Wait(1000) -- BUFFER  
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result and hasitem2 then
					print('You have this item sh')
					ProcessChemicals()
					print('processing chemicals')
					hasitem1 = false
					hasitem2 = false
				else
					QBCore.Functions.Notify('You lack some of the required items - Hydrochloric Acid, Sulfuric Acid or Sodium Hydroxide', 'error')
				end
			end, 'sodium_hydroxide')
		else
			QBCore.Functions.Notify('You are already processing something', 'error')
		end
	else
		Citizen.Wait(500)
	end
end)

RegisterNetEvent('ps-drugprocessing:ChangeTemp')
AddEventHandler('ps-drugprocessing:ChangeTemp', function()
	if not isTempChangeU then
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
			if result then
				print('You have this item HA')
				exports["memorygame"]:thermiteminigame(6, 3, 5, 10,
				function() -- success
					print("success")
					QBCore.Functions.Notify('Temperature Increase Successful', 'success')
					ProcessTempUp()
				end,
				function() -- failure
					print("failure")
					TriggerServerEvent('ps-drugprocessing:cancelProcessing')
					TriggerServerEvent('ps-drugprocessing:processFailUp')
				end)
			else
				QBCore.Functions.Notify('You lack some of the required items - Chemical Mix', 'error')
			end
		end, 'liquidmix')
	else
		QBCore.Functions.Notify('Temperature is Already Hot Enough', 'error')
	end
end)

RegisterNetEvent('ps-drugprocessing:ChangeTemp2')
AddEventHandler('ps-drugprocessing:ChangeTemp2', function()
	if not isTempChangeD then
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
			if result then
				print('You have this item HA')
				exports["memorygame"]:thermiteminigame(6, 3, 5, 10,
				function() -- success
					print("success")
					QBCore.Functions.Notify('Temperature Decrease Successful', 'success')
					ProcessTempDown()
				end,
				function() -- failure
					print("failure")
					TriggerServerEvent('ps-drugprocessing:cancelProcessing')
					TriggerServerEvent('ps-drugprocessing:processFailDown')
				end)
			else
				QBCore.Functions.Notify('You lack some of the required items - Chemical Vapor', 'error')
			end
		end, 'chemicalvapor')
	else
		QBCore.Functions.Notify('Temperature is Already Cold Enough', 'error')
	end
end)


RegisterNetEvent('ps-drugprocessing:ProcessProduct')
AddEventHandler('ps-drugprocessing:ProcessProduct', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if GetDistanceBetweenCoords(coords, Config.CircleZones.MethBag.coords, true) < 5 then
		if not isBagging then
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result then
					print('You have this item')
					ProcessProduct()
					print('processing meth')
				else
					QBCore.Functions.Notify('You lack the required items', 'error')
				end
			end, 'methtray')
		else
			QBCore.Functions.Notify('You are already processing something', 'error')
		end
	else
		Citizen.Wait(500)
	end
end)



function ProcessChemicals()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing Chemicals...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processChemicals')

	local timeLeft = Config.Delays.MethProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethProcessing.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
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

function ProcessTempUp()
	isTempChangeU = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Increasing Temperature...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processTempUp')

	local timeLeft = Config.Delays.MethProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethTemp.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)
	
	isTempChangeU = false
end

function ProcessTempDown()
	isTempChangeD = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Decreasing Temperature...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processTempDown')

	local timeLeft = Config.Delays.MethProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethTemp.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)
	
	isTempChangeD = false
end


function ProcessProduct()
	isBagging = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Bagging Up Meth...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processMeth')

	local timeLeft = Config.Delays.MethProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethBag.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)
	
	isBagging = false
end


RegisterNetEvent('ps-drugprocessing:EnterLab')
AddEventHandler('ps-drugprocessing:EnterLab', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.MethLab["enter"].coords.x, Config.MethLab["enter"].coords.y, Config.MethLab["enter"].coords.z))
    if dist < 2 then
		if not Methlab then
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result then
					print('You have the key')
					EnterMethlab()
					print('Entering Lab')
				else
					QBCore.Functions.Notify('You lack the required items', 'error')
				end
			end, 'methkey')
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ExitLab')
AddEventHandler('ps-drugprocessing:ExitLab', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.MethLab["exit"].coords.x, Config.MethLab["exit"].coords.y, Config.MethLab["exit"].coords.z))
    if dist < 2 then
		ExitMethlab()
		print('Exiting Lab')
	end
end)


function EnterMethlab()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    Methlab = true
    Citizen.Wait(500)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    SetEntityCoords(ped, Config.MethLab["exit"].coords.x, Config.MethLab["exit"].coords.y, Config.MethLab["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.MethLab["exit"].coords.w)
    Citizen.Wait(1000)
    DoScreenFadeIn(250)
end

function ExitMethlab()
    local ped = PlayerPedId()
    local dict = "mp_heists@keypad@"
    local keypad = {coords = {x = 969.04, y = -146.17, z = -46.4, h = 94.5, r = 1.0}}
    SetEntityCoords(ped, keypad.coords.x, keypad.coords.y, keypad.coords.z - 0.98)
    SetEntityHeading(ped, keypad.coords.h)
	Methlab = true
    LoadAnimationDict(dict) 
    TaskPlayAnim(ped, "mp_heists@keypad@", "idle_a", 8.0, 8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(2500)
    TaskPlayAnim(ped, "mp_heists@keypad@", "exit", 2.0, 2.0, -1, 0, 0, false, false, false)
    Citizen.Wait(1000)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    SetEntityCoords(ped, Config.MethLab["enter"].coords.x, Config.MethLab["enter"].coords.y, Config.MethLab["enter"].coords.z - 0.98)
    SetEntityHeading(ped, Config.MethLab["enter"].coords.w)
    Methlab = false
    Citizen.Wait(1000)
    DoScreenFadeIn(250)
end

function LoadAnimationDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function OpenDoorAnimation()
    local ped = PlayerPedId()
    LoadAnimationDict("anim@heists@keycard@") 
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Citizen.Wait(400)
    ClearPedTasks(ped)
end
