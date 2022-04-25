local QBCore = exports['qb-core']:GetCoreObject()
local playersProcessingCannabis = {}

RegisterServerEvent('ps-drugtrafficking:pickedUpCannabis')
AddEventHandler('ps-drugtrafficking:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("cannabis", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cannabis"], "add")
end)

RegisterServerEvent('ps-drugtrafficking:processCannabis')
AddEventHandler('ps-drugtrafficking:processCannabis', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('cannabis', 1)
	Player.Functions.AddItem('marijuana', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Cannabis successfully processed!', "success")
end)

RegisterServerEvent('ps-drugtrafficking:rollJoint')
AddEventHandler('ps-drugtrafficking:rollJoint', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('marijuana', 1)
	Player.Functions.RemoveItem('rolling_paper', 1)
	Player.Functions.AddItem('joint', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['rolling_paper'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'You successfully rolled a joint!', "success")
end)

function CancelProcessing(playerId)
	if playersProcessingCocaLeaf[playerId] then
		ClearTimeout(playersProcessingCocaLeaf[playerId])
		playersProcessingCocaLeaf[playerId] = nil
	end
end

RegisterServerEvent('ps-drugtrafficking:cancelProcessing')
AddEventHandler('ps-drugtrafficking:cancelProcessing', function()
	CancelProcessing(source)
end)

QBCore.Functions.CreateUseableItem("rolling_paper", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('ps-drugtrafficking:client:rollJoint', source, 'marijuana', item)
end)