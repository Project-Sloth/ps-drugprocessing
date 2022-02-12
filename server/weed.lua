local QBCore = exports['qb-core']:GetCoreObject()

local playersProcessingCannabis = {}

RegisterServerEvent('qb-drugtrafficking:pickedUpCannabis')
AddEventHandler('qb-drugtrafficking:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("cannabis", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cannabis"], "add")
end)

RegisterServerEvent('qb-drugtrafficking:processCannabis')
AddEventHandler('qb-drugtrafficking:processCannabis', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('cannabis', 1)
	Player.Functions.AddItem('marijuana', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Cannabis successfully processed!', "success")
end)

RegisterServerEvent('qb-drugtrafficking:rollJoint')
AddEventHandler('qb-drugtrafficking:rollJoint', function()
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

RegisterServerEvent('qb-drugtrafficking:cancelProcessing')
AddEventHandler('qb-drugtrafficking:cancelProcessing', function()
	CancelProcessing(source)
end)

QBCore.Functions.CreateUseableItem("rolling_paper", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-drugtrafficking:client:rollJoint', source, 'marijuana', item)
end)