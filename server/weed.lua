
GlobalState.psWeed = Config.Drugs.WeedPlants

local function cooldownWeed(location)
	if Config.Drugs.WeedPlants[location] then
		Config.Drugs.WeedPlants[location].taken = true
		GlobalState.psWeed = Config.Drugs.WeedPlants
		TriggerClientEvent('ps-drugprocessing:removeWeed', -1, location)
		CreateThread(function()
			Wait(1000 * 5)
			Config.Drugs.WeedPlants[location].taken = false
			GlobalState.psWeed = Config.Drugs.WeedPlants
			TriggerClientEvent('ps-drugprocessing:addWeed', -1, location)
		end)
	end
end

RegisterServerEvent('ps-drugprocessing:pickedUpCannabis', function(location)
	local src = source
	if Config.Drugs.WeedPlants[location].taken then
		ps.debug(ps.getPlayerName(src) .. " Tried to Get Weed at " .. location .. ' but it was set to taken')
		return
	end
	if not ps.checkDistance(src, Config.Drugs.WeedPlants[location].loc, 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	if ps.addItem(src,"cannabis", 1) then
		cooldownWeed(location)
		ps.notify(src, Lang:t("success.cannabis"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processCannabis', function()
	local src = source
	if not ps.checkDistance(src, vector3(1038.33, -3204.44, -38.17), 2.0) then
		return
	end
	if ps.removeItem(src, 'cannabis', 1) then
		if ps.addItem(src, 'marijuana', 1) then
			ps.notify(src, Lang:t("success.processed_cannabis"), "success")
		end
	else
		ps.notify(src, Lang:t("error.no_cannabis"), "error")
	end
end)

ps.createUseable("rolling_paper", function(source, item)
	if not ps.verifyRecipe(source, {
		rolling_paper = 1,
		marijuana = 1
	}) then
		ps.notify(source, Lang:t("error.no_item", {item = "marijuana"}), "error")
		return
	end
	TriggerClientEvent('ps-drugprocessing:client:rollJoint', source)
end)

ps.createUseable("empty_weed_bag", function(source, item)
	if not ps.verifyRecipe(source, {
		empty_weed_bag = 1,
		marijuana = 1
	}) then
		ps.notify(source, Lang:t("error.no_item", {item = "marijuana"}), "error")
		return
	end
    TriggerClientEvent('ps-drugprocessing:client:bagskunk', source, 'marijuana', item)
end)


RegisterServerEvent('ps-drugprocessing:bagskunk', function()
	local src = source
    ps.craftItem(src, {
		take = {
			marijuana = 1,
			empty_weed_bag = 1
		},
		give = {
			weed_skunk = 1
		}
	})
end)

RegisterServerEvent('ps-drugprocessing:rollJoint', function()
	local src = source
	ps.craftItem(src, {
		take = {
			marijuana = 1,
			rolling_paper = 1
		},
		give = {
			joint = 1
		}
	})
end)
