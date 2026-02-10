GlobalState.psHeroin = Config.Drugs.heroin

local function cooldownPoppy(location)
	if Config.Drugs.heroin[location] then
		Config.Drugs.heroin[location].taken = true
		GlobalState.psHeroin = Config.Drugs.heroin
		TriggerClientEvent('ps-drugprocessing:removePoppy', -1, location)
		CreateThread(function()
			Wait(1000 * 10)
			Config.Drugs.heroin[location].taken = false
			GlobalState.psHeroin = Config.Drugs.heroin
			TriggerClientEvent('ps-drugprocessing:addPoppy', -1, location)
		end)
	end
end
RegisterServerEvent('ps-drugprocessing:pickedUpPoppy', function(location)
	local src = source
	if not ps.checkDistance(src, Config.Drugs.heroin[location].loc, 2.0) then
		ps.debug(src, Lang:t("error.not_in_range"), "error")
		return
	end
	if Config.Drugs.heroin[location].taken then
		ps.debug(ps.getPlayerName(src) .. " Tried to Get Poppy at " .. location .. ' but it was set to taken')
		return
	end

	if ps.addItem(src, "poppyresin", 1) then
		cooldownPoppy(location)
		ps.notify(src, Lang:t("success.poppyresin"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processPoppyResin', function()
	local src = source
	if not ps.checkDistance(src, vector3(1384.9, -2080.61, 52.21), 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			poppyresin = Config.HeroinProcessing.Poppy,
		},
		give = {
			heroin = 1,
		}
	})
end)
