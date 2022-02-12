local isPickingUp, isProcessing, requiredItemsShowed, hasitem1, hasitem2, hasitem3 = false, false, false, false, false, false
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
end)]]

function ProcessMeth()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing Meth...", 15000, false, true, {
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

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.MethProcessing.coords, false) > 2 then
				QBCore.Functions.Notify('The processing has been canceled due to you abandoning the area')
				TriggerServerEvent('qb-drugtrafficking:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)

	isProcessing = false
end

Citizen.CreateThread(function()
	exports['qb-target']:AddBoxZone("methproc", vector3(1782.29, 3906.1, 39.8), 0.6, 0.8, {
		name="methproc",
		heading=20.0,
		debugPoly=false,
		minZ = 36.8,
		maxZ = 40.6,
	  },{
		options = {
				{
				  type = "client",
				  event = "qb-crafting:opencraftingtable",
				  icon = "fas fa-biohazard",
				  label = "Process Meth",
				},
			 },
		distance = 2.5
		 })
   end)