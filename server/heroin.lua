local playersProcessingPoppyResin = {}
local QBCore = exports['ps-core']:GetCoreObject()

RegisterServerEvent('ps-drugtrafficking:pickedUpPoppy')
AddEventHandler('ps-drugtrafficking:pickedUpPoppy', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("poppyresin", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["poppyresin"], "add")
end)

RegisterServerEvent('ps-drugtrafficking:processPoppyResin')
AddEventHandler('ps-drugtrafficking:processPoppyResin', function()
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

RegisterServerEvent('ps-drugtrafficking:cancelProcessing')
AddEventHandler('ps-drugtrafficking:cancelProcessing', function()
	CancelProcessing(source)
end)