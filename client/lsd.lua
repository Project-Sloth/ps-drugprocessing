local isPickingUp, isProcessing, requiredItemsShowed, hasitem1, hasitem2 = false, false, false, false, false
local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        if GetDistanceBetweenCoords(coords, Config.CircleZones.lsdProcessing.coords, true) < 2 then
            if not isProcessing then
                local pos = GetEntityCoords(PlayerPedId())
                QBCore.Functions.DrawText3D(pos.x, pos.y, pos.z, Lang:t("drawtext.process_lsd"))
            end

            if IsControlJustReleased(0, 38) and not isProcessing then
				
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					if result then
						hasitem1 = true
					else
						QBCore.Functions.Notify(Lang:t("error.no_lsa"), 'error')
					end
				end, 'lsa')
				Citizen.Wait(1000) -- BUFFER

                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    if result and hasitem1 then
                        Processlsd()
						hasitem1 = false
                    else
                        QBCore.Functions.Notify(Lang:t("error.no_thionyl_chloride"), 'error')
                    end
                end, 'thionyl_chloride')
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function Processlsd()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:Processlsd')

		local timeLeft = Config.Delays.lsdProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.lsdProcessing.coords, false) > 5 then
				QBCore.Functions.Notify(Lang:t("error.too_far"))
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

RegisterNetEvent('ps-drugprocessing:processingThiChlo')
AddEventHandler('ps-drugprocessing:processingThiChlo', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if GetDistanceBetweenCoords(coords, Config.CircleZones.thionylchlorideProcessing.coords, true) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result then
					print('nice')
					hasitem1 = true
				else
					QBCore.Functions.Notify('You dont have the correct items', 'error')
				end
			end, 'lsa')
			Citizen.Wait(1000) -- BUFFER
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result and hasitem1 then
					print('nice')
					Processthionylchloride()
				else
					QBCore.Functions.Notify('You dont have the correct items', 'error')
				end
			end, 'chemicals')
		end
	end
end)


function Processthionylchloride()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processThionylChloride')

	local timeLeft = Config.Delays.thionylchlorideProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.thionylchlorideProcessing.coords, false) > 5 then
				QBCore.Functions.Notify(Lang:t("error.too_far"))
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