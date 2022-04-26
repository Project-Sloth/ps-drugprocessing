local QBCore = exports['qb-core']:GetCoreObject()

local playersProcessingChemicalsToHydrochloricAcid = {}

RegisterServerEvent('qb-drugtrafficking:pickedUpChemicals')
AddEventHandler('qb-drugtrafficking:pickedUpChemicals', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("chemicals", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicals"], "add")
end)

RegisterServerEvent('qb-drugtrafficking:processHydrochloric_acid')
AddEventHandler('qb-drugtrafficking:processHydrochloric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('hydrochloric_acid', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['hydrochloric_acid'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Hydrochloric acid process was succesful !', "success")
end)

RegisterServerEvent('qb-drugtrafficking:processsodium_hydroxide')
AddEventHandler('qb-drugtrafficking:processsodium_hydroxide', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('sodium_hydroxide', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sodium_hydroxide'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Sodium Hydroxide process was succesful !', "success")
end)

RegisterServerEvent('qb-drugtrafficking:processprocess_sulfuric_acid')
AddEventHandler('qb-drugtrafficking:processprocess_sulfuric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('sulfuric_acid', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sulfuric_acid'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Sulfuric Acid process was succesful !', "success")
end)

RegisterServerEvent('qb-drugtrafficking:process_lsa')
AddEventHandler('qb-drugtrafficking:process_lsa', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('lsa', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsa'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Sulfuric Acid process was succesful !', "success")
end)