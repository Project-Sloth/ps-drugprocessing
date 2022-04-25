local playersProcessingMeth = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugtrafficking:pickedUpHydrochloricAcid')
AddEventHandler('ps-drugtrafficking:pickedUpHydrochloricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("hydrochloric_acid", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hydrochloric_acid"], "add")
end)

RegisterServerEvent('ps-drugtrafficking:pickedUpSodiumHydroxide')
AddEventHandler('ps-drugtrafficking:pickedUpSodiumHydroxide', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("sodium_hydroxide", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sodium_hydroxide"], "add")
end)

RegisterServerEvent('ps-drugtrafficking:pickedUpSulfuricAcid')
AddEventHandler('ps-drugtrafficking:pickedUpSulfuricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("sulfuric_acid", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sulfuric_acid"], "add")
end)

RegisterServerEvent('ps-drugtrafficking:processChemicals')
AddEventHandler('ps-drugtrafficking:processChemicals', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.AddItem("liquidmix", 1)
		Player.Functions.RemoveItem("sulfuric_acid", 1)
		Player.Functions.RemoveItem("hydrochloric_acid", 1)
		Player.Functions.RemoveItem("sodium_hydroxide", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["liquidmix"], "add")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sulfuric_acid"], "remove")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hydrochloric_acid"], "remove")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sodium_hydroxide"], "remove")
	end
end)

RegisterServerEvent('ps-drugtrafficking:processTempUp')
AddEventHandler('ps-drugtrafficking:processTempUp', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.AddItem("chemicalvapor", 1)
		Player.Functions.RemoveItem("liquidmix", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicalvapor"], "add")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["liquidmix"], "remove")
	end
end)

RegisterServerEvent('ps-drugtrafficking:processTempDown')
AddEventHandler('ps-drugtrafficking:processTempDown', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.AddItem("methtray", 1)
		Player.Functions.RemoveItem("chemicalvapor", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["methtray"], "add")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicalvapor"], "remove")
	end
end)

RegisterServerEvent('ps-drugtrafficking:processMeth')
AddEventHandler('ps-drugtrafficking:processMeth', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		local quantity = math.random(5, 12)

		Player.Functions.AddItem("meth", quantity)
		Player.Functions.RemoveItem("methtray", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth"], "add")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["methtray"], "remove")
	end
end)

RegisterServerEvent('ps-drugtrafficking:processFailUp')
AddEventHandler('ps-drugtrafficking:processFailUp', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.RemoveItem("liquidmix", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["liquidmix"], "remove")
	end
end)

RegisterServerEvent('ps-drugtrafficking:processFailDown')
AddEventHandler('ps-drugtrafficking:processFailDown', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.RemoveItem("chemicalvapor", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicalvapor"], "add")
	end
end)

function CancelProcessing(playerID)
	if playersProcessingMeth[playerID] then
		playersProcessingMeth[playerID] = nil
	end
end

RegisterServerEvent('ps-drugtrafficking:cancelProcessing')
AddEventHandler('ps-drugtrafficking:cancelProcessing', function()
	CancelProcessing(source)
end)

