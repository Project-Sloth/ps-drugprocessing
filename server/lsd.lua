local playersProcessingLSD = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugtrafficking:Processlsd')
AddEventHandler('ps-drugtrafficking:Processlsd', function()
	if not playersProcessingLSD[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.RemoveItem("lsa", 1)
		Player.Functions.RemoveItem("thionyl_chloride", 1)
		Player.Functions.AddItem("lsd", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lsd"], "add")
	end
end)

RegisterServerEvent('ps-drugtrafficking:processThionylChloride')
AddEventHandler('ps-drugtrafficking:processThionylChloride', function()
	if not playersProcessingLSD[source] then
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.AddItem("thionyl_chloride", 1)
		Player.Functions.RemoveItem("lsa", 1)
		Player.Functions.RemoveItem("chemicals", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["thionyl_chloride"], "add")
	end
end)

function CancelProcessing(playerID)
	if playersProcessingLSD[playerID] then
		playersProcessingLSD[playerID] = nil
	end
end

RegisterServerEvent('ps-drugtrafficking:cancelProcessing')
AddEventHandler('ps-drugtrafficking:cancelProcessing', function()
	CancelProcessing(source)
end)