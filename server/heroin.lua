local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugprocessing:pickedUpPoppy', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("poppyresin", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["poppyresin"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.poppyresin"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processPoppyResin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('poppyresin', Config.HeroinProcessing.Poppy) then
		if Player.Functions.AddItem('heroin', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", Config.HeroinProcessing.Poppy)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.heroin"), "success")
		else
			Player.Functions.AddItem('poppyresin', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_poppy_resin"), "error")
	end
end)
