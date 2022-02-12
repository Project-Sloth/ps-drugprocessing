local playersProcessingMeth = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-drugtrafficking:pickedUpHydrochloricAcid')
AddEventHandler('qb-drugtrafficking:pickedUpHydrochloricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("hydrochloric_acid", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hydrochloric_acid"], "add")
end)

RegisterServerEvent('qb-drugtrafficking:pickedUpSodiumHydroxide')
AddEventHandler('qb-drugtrafficking:pickedUpSodiumHydroxide', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("sodium_hydroxide", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sodium_hydroxide"], "add")
end)

RegisterServerEvent('qb-drugtrafficking:pickedUpSulfuricAcid')
AddEventHandler('qb-drugtrafficking:pickedUpSulfuricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("sulfuric_acid", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sulfuric_acid"], "add")
end)

RegisterServerEvent('qb-drugtrafficking:processMeth')
AddEventHandler('qb-drugtrafficking:processMeth', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.AddItem("meth", 1)
		Player.Functions.RemoveItem("sulfuric_acid", 1)
		Player.Functions.RemoveItem("hydrochloric_acid", 1)
		Player.Functions.RemoveItem("sodium_hydroxide", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth"], "add")
	end
end)

function CancelProcessing(playerID)
	if playersProcessingMeth[playerID] then
		playersProcessingMeth[playerID] = nil
	end
end

RegisterServerEvent('qb-drugtrafficking:cancelProcessing')
AddEventHandler('qb-drugtrafficking:cancelProcessing', function()
	CancelProcessing(source)
end)