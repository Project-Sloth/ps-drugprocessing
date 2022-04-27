local playersProcessingMeth = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugprocessing:pickedUpHydrochloricAcid')
AddEventHandler('ps-drugprocessing:pickedUpHydrochloricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("hydrochloric_acid", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hydrochloric_acid"], "add")
end)

RegisterServerEvent('ps-drugprocessing:pickedUpSodiumHydroxide')
AddEventHandler('ps-drugprocessing:pickedUpSodiumHydroxide', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("sodium_hydroxide", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sodium_hydroxide"], "add")
end)

RegisterServerEvent('ps-drugprocessing:pickedUpSulfuricAcid')
AddEventHandler('ps-drugprocessing:pickedUpSulfuricAcid', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("sulfuric_acid", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sulfuric_acid"], "add")
end)

RegisterServerEvent('ps-drugprocessing:processChemicals')
AddEventHandler('ps-drugprocessing:processChemicals', function()
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

RegisterServerEvent('ps-drugprocessing:processTempUp')
AddEventHandler('ps-drugprocessing:processTempUp', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.AddItem("chemicalvapor", 1)
		Player.Functions.RemoveItem("liquidmix", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicalvapor"], "add")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["liquidmix"], "remove")
	end
end)

RegisterServerEvent('ps-drugprocessing:processTempDown')
AddEventHandler('ps-drugprocessing:processTempDown', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.AddItem("methtray", 1)
		Player.Functions.RemoveItem("chemicalvapor", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["methtray"], "add")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicalvapor"], "remove")
	end
end)

RegisterServerEvent('ps-drugprocessing:processMeth')
AddEventHandler('ps-drugprocessing:processMeth', function()
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

RegisterServerEvent('ps-drugprocessing:processFailUp')
AddEventHandler('ps-drugprocessing:processFailUp', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.RemoveItem("liquidmix", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["liquidmix"], "remove")
	end
end)

RegisterServerEvent('ps-drugprocessing:processFailDown')
AddEventHandler('ps-drugprocessing:processFailDown', function()
	if not playersProcessingMeth[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.RemoveItem("chemicalvapor", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicalvapor"], "remove")
	end
end)

function CancelProcessing(playerID)
	if playersProcessingMeth[playerID] then
		playersProcessingMeth[playerID] = nil
	end
end

RegisterServerEvent('ps-drugprocessing:cancelProcessing')
AddEventHandler('ps-drugprocessing:cancelProcessing', function()
	CancelProcessing(source)
end)

