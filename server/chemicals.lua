local QBCore = exports['qb-core']:GetCoreObject()

local playersProcessingChemicalsToHydrochloricAcid = {}

RegisterServerEvent('ps-drugprocessing:pickedUpChemicals')
AddEventHandler('ps-drugprocessing:pickedUpChemicals', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("chemicals", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicals"], "add")
end)

RegisterServerEvent('ps-drugprocessing:processHydrochloric_acid')
AddEventHandler('ps-drugprocessing:processHydrochloric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('hydrochloric_acid', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['hydrochloric_acid'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Hydrochloric acid process was succesful !', "success")
end)

RegisterServerEvent('ps-drugprocessing:processsodium_hydroxide')
AddEventHandler('ps-drugprocessing:processsodium_hydroxide', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('sodium_hydroxide', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sodium_hydroxide'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Sodium Hydroxide process was succesful !', "success")
end)

RegisterServerEvent('ps-drugprocessing:processprocess_sulfuric_acid')
AddEventHandler('ps-drugprocessing:processprocess_sulfuric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('sulfuric_acid', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sulfuric_acid'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Sulfuric Acid process was succesful !', "success")
end)

RegisterServerEvent('ps-drugprocessing:process_lsa')
AddEventHandler('ps-drugprocessing:process_lsa', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('lsa', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsa'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Sulfuric Acid process was succesful !', "success")
end)