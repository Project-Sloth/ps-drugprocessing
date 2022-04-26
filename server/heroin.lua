local playersProcessingPoppyResin = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-drugtrafficking:pickedUpPoppy')
AddEventHandler('qb-drugtrafficking:pickedUpPoppy', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("poppyresin", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["poppyresin"], "add")
end)

RegisterServerEvent('qb-drugtrafficking:processPoppyResin')
AddEventHandler('qb-drugtrafficking:processPoppyResin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('poppyresin', 1)
	Player.Functions.AddItem('heroin', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Heroin successfully processed!', "success")
end)

function CancelProcessing(playerID)
	if playersProcessingPoppyResin[playerID] then
		ClearTimeout(playersProcessingCocaLeaf[playerId])
		playersProcessingPoppyResin[playerID] = nil
	end
end

RegisterServerEvent('qb-drugtrafficking:cancelProcessing')
AddEventHandler('qb-drugtrafficking:cancelProcessing', function()
	CancelProcessing(source)
end)