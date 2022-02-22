local  isProcessing, isTempChangeU, isTempChangeD, isBagging, hasitem1, hasitem2 = false, false, false, false, false, false
local QBCore = exports['qb-core']:GetCoreObject()

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        if GetDistanceBetweenCoords(coords, Config.CircleZones.MethProcessing.coords, true) < 5 then
            if not isProcessing then
                local pos = GetEntityCoords(PlayerPedId())
                QBCore.Functions.DrawText3D(pos.x, pos.y, pos.z, "E - Process Meth")
            end

            if IsControlJustReleased(0, 38) and not isProcessing then
                
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    if result then
                        hasitem1 = true
                    else
                        QBCore.Functions.Notify('You lack some of the required items - Hydrochloric Acid, Sulfuric Acid or Sodium Hydroxide', 'error')
                    end
                end, 'sulfuric_acid')
                Citizen.Wait(1000) -- BUFFER

                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    if result and hasitem1 then
                        hasitem2 = true
                    else
                        QBCore.Functions.Notify('You lack some of the required items - Hydrochloric Acid, Sulfuric Acid or Sodium Hydroxide', 'error')
                    end
                end, 'hydrochloric_acid')
				Citizen.Wait(1000) -- BUFFER  
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    if result and hasitem2 then
                        ProcessMeth()
                        hasitem1 = false
                        hasitem2 = false
                    else
                        QBCore.Functions.Notify('You lack some of the required items - Hydrochloric Acid, Sulfuric Acid or Sodium Hydroxide', 'error')
                    end
                end, 'sodium_hydroxide')
            end
        else
            Citizen.Wait(500)
        end
    end
end)]]--

RegisterNetEvent('qb-drugprocessing:ProcessChemicals')
AddEventHandler('qb-drugprocessing:ProcessChemicals', function()
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

RegisterNetEvent('qb-drugprocessing:ChangeTemp')
AddEventHandler('qb-drugprocessing:ChangeTemp', function()
	if not isTempChangeU then
		exports["memorygame"]:thermiteminigame(6, 3, 5, 10,
		function() -- success
			print("success")
			QBCore.Functions.Notify('Temperature Increase Successful', 'success')
			ProcessTempUp()
		end,
		function() -- failure
			print("failure")
			TriggerServerEvent('qb-drugtrafficking:cancelProcessing')
			TriggerServerEvent('qb-drugtrafficking:processFailUp')
		end)
	else
		QBCore.Functions.Notify('Temperature is Already Hot Enough', 'error')
	end
end)

RegisterNetEvent('qb-drugprocessing:ChangeTemp2')
AddEventHandler('qb-drugprocessing:ChangeTemp2', function()
	if not isTempChangeD then
		exports["memorygame"]:thermiteminigame(6, 3, 5, 10,
		function() -- success
			print("success")
			QBCore.Functions.Notify('Temperature Decrease Successful', 'success')
			ProcessTempDown()
		end,
		function() -- failure
			print("failure")
			TriggerServerEvent('qb-drugtrafficking:cancelProcessing')
			TriggerServerEvent('qb-drugtrafficking:processFailDown')
		end)
	else
		QBCore.Functions.Notify('Temperature is Already Hot Enough', 'error')
	end
end)

RegisterNetEvent('qb-drugprocessing:ProcessProduct')
AddEventHandler('qb-drugprocessing:ProcessProduct', function()
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
	TriggerServerEvent('qb-drugtrafficking:processChemicals')

	local timeLeft = Config.Delays.MethProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethProcessing.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
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
	TriggerServerEvent('qb-drugtrafficking:processTempUp')

	local timeLeft = Config.Delays.MethProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethTemp.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
				TriggerServerEvent('qb-drugtrafficking:cancelProcessing')
				break
			end
		end
		StopAnimTask(PlayerPedId())
	end, function()
		StopAnimTask(PlayerPedId())
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
	TriggerServerEvent('qb-drugtrafficking:processTempDown')

	local timeLeft = Config.Delays.MethProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethTemp.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
				TriggerServerEvent('qb-drugtrafficking:cancelProcessing')
				break
			end
		end
		StopAnimTask(PlayerPedId())
	end, function()
		StopAnimTask(PlayerPedId())
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
	TriggerServerEvent('qb-drugtrafficking:processMeth')

	local timeLeft = Config.Delays.MethProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethBag.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
				TriggerServerEvent('qb-drugtrafficking:cancelProcessing')
				break
			end
		end
		StopAnimTask(PlayerPedId())
	end, function()
		StopAnimTask(PlayerPedId())
	end)
	
	isBagging = false
end