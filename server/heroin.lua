local playersProcessingPoppyResin = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugprocessing:pickedUpPoppy')
AddEventHandler('ps-drugprocessing:pickedUpPoppy', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("poppyresin", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["poppyresin"], "add")
	TriggerClientEvent('QBCore:Notify', src, Lang:t("success.poppyresin"), "success")
end)

RegisterServerEvent('ps-drugprocessing:processPoppyResin')
AddEventHandler('ps-drugprocessing:processPoppyResin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('poppyresin', Config.Poppy)
	Player.Functions.AddItem('heroin', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", Config.Poppy)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "add")
	TriggerClientEvent('QBCore:Notify', src, Lang:t("success.heroin"), "success")
end)

function CancelProcessing(playerID)
	if playersProcessingPoppyResin[playerID] then
		ClearTimeout(playersProcessingCocaLeaf[playerId])
		playersProcessingPoppyResin[playerID] = nil
	end
end

RegisterServerEvent('ps-drugprocessing:cancelProcessing')
AddEventHandler('ps-drugprocessing:cancelProcessing', function()
	CancelProcessing(source)
end)