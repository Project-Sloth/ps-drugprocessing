local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugprocessing:pickedUpChemicals', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("chemicals", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["chemicals"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.chemicals"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processHydrochloric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('hydrochloric_acid', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['hydrochloric_acid'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.hydrochloric_acid"), "success")
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:processsodium_hydroxide', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('sodium_hydroxide', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sodium_hydroxide'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.sodium_hydroxide"), "success")
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:processprocess_sulfuric_acid', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('sulfuric_acid', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sulfuric_acid'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.sulfuric_acid"), "success")
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:process_lsa', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('chemicals', 1) then
		if Player.Functions.AddItem('lsa', 1) then 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsa'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.lsa"), "success")
		else
			Player.Functions.AddItem('chemicals', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_chemicals"), "error")
	end
end)


QBCore.Functions.CreateCallback('ps-drugprocessing:validate_items', function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

	local hasItems = {
		ret = true,
		item = ''
	}
	for name,amount in pairs(data) do
		local item = Player.Functions.GetItemByName(name)
		if not item or item and item.amount < amount then
			hasItems.ret = false
			hasItems.item = QBCore.Shared.Items[name].label .. ', ' .. hasItems.item
		end
		if not hasItems then break end
	end
	hasItems.item = string.gsub(hasItems.item, ', $', '')
	cb(hasItems)
end)