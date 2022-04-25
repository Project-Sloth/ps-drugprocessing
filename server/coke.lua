local playersProcessingCocaLeaf = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugprocessing:pickedUpCocaLeaf')
AddEventHandler('ps-drugprocessing:pickedUpCocaLeaf', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("coca_leaf", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["coca_leaf"], "add")
end)

RegisterServerEvent('ps-drugprocessing:processCocaLeaf')
AddEventHandler('ps-drugprocessing:processCocaLeaf', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local count = math.random(2,7)

	Player.Functions.RemoveItem('coca_leaf', 1)
	Player.Functions.AddItem('coke', count)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "add", count)
	TriggerClientEvent('QBCore:Notify', src, 'Cocaine Leafs successfully processed!', "success")
end)

RegisterServerEvent('ps-drugprocessing:processCocaPowder')
AddEventHandler('ps-drugprocessing:processCocaPowder', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local count = math.random(1,2)

	Player.Functions.RemoveItem('coke', 10)
	Player.Functions.RemoveItem('bakingsoda', 5)
	Player.Functions.AddItem('coke_small_brick', count)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "remove", 10)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 5)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_small_brick'], "add", count)
	TriggerClientEvent('QBCore:Notify', src, 'Cocaine Powder successfully Cut!', "success")
end)

RegisterServerEvent('ps-drugprocessing:processCocaBrick')
AddEventHandler('ps-drugprocessing:processCocaBrick', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('coke_small_brick', 4)
	Player.Functions.AddItem('coke_brick', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_small_brick'], "remove", 4)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_brick'], "add", 1)
	TriggerClientEvent('QBCore:Notify', src, 'Cocaine Brick Pressed for Distro!', "success")
end)

function CancelProcessing(playerId)
	if playersProcessingCocaLeaf[playerId] then
		ClearTimeout(playersProcessingCocaLeaf[playerId])
		playersProcessingCocaLeaf[playerId] = nil
	end
end

RegisterServerEvent('ps-drugprocessing:cancelProcessing')
AddEventHandler('ps-drugprocessing:cancelProcessing', function()
	CancelProcessing(source)
end)

