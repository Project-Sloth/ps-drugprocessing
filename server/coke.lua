local playersProcessingCocaLeaf = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-drugtrafficking:pickedUpCocaLeaf')
AddEventHandler('qb-drugtrafficking:pickedUpCocaLeaf', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("coca_leaf", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["coca_leaf"], "add")
end)

RegisterServerEvent('qb-drugtrafficking:processCocaLeaf')
AddEventHandler('qb-drugtrafficking:processCocaLeaf', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('coca_leaf', 1)
	Player.Functions.AddItem('coke', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Cocaine Leafs successfully processed!', "success")
end)

function CancelProcessing(playerId)
	if playersProcessingCocaLeaf[playerId] then
		ClearTimeout(playersProcessingCocaLeaf[playerId])
		playersProcessingCocaLeaf[playerId] = nil
	end
end

RegisterServerEvent('qb-drugtrafficking:cancelProcessing')
AddEventHandler('qb-drugtrafficking:cancelProcessing', function()
	CancelProcessing(source)
end)