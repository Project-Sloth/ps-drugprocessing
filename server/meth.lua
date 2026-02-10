
GlobalState.psHydro = Config.Drugs.hydro
GlobalState.psSodium = Config.Drugs.sodium
GlobalState.psSulfuric = Config.Drugs.sulfuric

local function cooldownHydro(location)
	if Config.Drugs.hydro[location] then
		Config.Drugs.hydro[location].taken = true
		GlobalState.psHydro = Config.Drugs.hydro
		TriggerClientEvent('ps-drugprocessing:removeHydrochloricAcid', -1, location)
		CreateThread(function()
			Wait(1000 * 10)
			Config.Drugs.hydro[location].taken = false
			GlobalState.psHydro = Config.Drugs.hydro
			TriggerClientEvent('ps-drugprocessing:addHydrochloricAcid', -1, location)
		end)
	end
end

RegisterServerEvent('ps-drugprocessing:pickedUpHydrochloricAcid', function(location)
	local src = source
	if not ps.checkDistance(src, Config.Drugs.hydro[location].loc, 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	if Config.Drugs.hydro[location].taken then
		ps.debug(ps.getPlayerName(src) .. " Tried to Get hydrochloric acid at " .. location .. ' but it was set to taken')
		return
	end

	if ps.addItem(src,"hydrochloric_acid", 1) then
		cooldownHydro(location)
		ps.notify(src, Lang:t("success.hydrochloric_acid"), "success")
	end
end)

local function cooldownSodium(location)
	if Config.Drugs.sodium[location] then
		Config.Drugs.sodium[location].taken = true
		GlobalState.psSodium = Config.Drugs.sodium
		TriggerClientEvent('ps-drugprocessing:removeSodiumHydroxide', -1, location)
		CreateThread(function()
			Wait(1000 * 10)
			Config.Drugs.sodium[location].taken = false
			GlobalState.psSodium = Config.Drugs.sodium
			TriggerClientEvent('ps-drugprocessing:addSodiumHydroxide', -1, location)
		end)
	end
end

RegisterServerEvent('ps-drugprocessing:pickedUpSodiumHydroxide', function(location)
	local src = source
	if not ps.checkDistance(src, Config.Drugs.sodium[location].loc, 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	if Config.Drugs.sodium[location].taken then
		ps.debug(ps.getPlayerName(src) .. " Tried to Get sodium hydroxide at " .. location .. ' but it was set to taken')
		return
	end
	if ps.addItem(src, "sodium_hydroxide", 1) then
		cooldownSodium(location)
		ps.notify(src, Lang:t("success.sodium_hydroxide"), "success")
	end
end)


local function cooldownSulfuric(location)
	if Config.Drugs.sulfuric[location] then
		Config.Drugs.sulfuric[location].taken = true
		GlobalState.psSulfuric = Config.Drugs.sulfuric
		TriggerClientEvent('ps-drugprocessing:removeSulfuricAcid', -1, location)
		CreateThread(function()
			Wait(1000 * 10)
			Config.Drugs.sulfuric[location].taken = false
			GlobalState.psSulfuric = Config.Drugs.sulfuric
			TriggerClientEvent('ps-drugprocessing:addSulfuricAcid', -1, location)
		end)
	end
end

RegisterServerEvent('ps-drugprocessing:pickedUpSulfuricAcid', function(location)
	local src = source
	if not ps.checkDistance(src, Config.Drugs.sulfuric[location].loc, 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	if Config.Drugs.sulfuric[location].taken then
		ps.debug(ps.getPlayerName(src) .. " Tried to Get sulfuric acid at " .. location .. ' but it was set to taken')
		return
	end
	if ps.addItem("sulfuric_acid", 1) then
		cooldownSulfuric(location)
		ps.notify(src, Lang:t("success.sulfuric_acid"), "success")
	end
end)


----
RegisterServerEvent('ps-drugprocessing:processChemicals', function()
	local src = source
	if not ps.checkDistance(src, vector3(978.22, -147.1, -48.53), 5.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src,  {
		take = {
			sulfuric_acid = Config.MethProcessing.SulfAcid,
			hydrochloric_acid = Config.MethProcessing.HydAcid,
			sodium_hydroxide = Config.MethProcessing.SodHyd,
		},
		give = {
			liquidmix = 1,
		}
	})
end)

RegisterServerEvent('ps-drugprocessing:processTempUp', function()
	local src = source
	if not ps.checkDistance(src, vector3(982.56, -145.59, -49.0), 5.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			liquidmix = 1,
		},
		give = {
			chemicalvapor = 1,
		}
	})
end)

RegisterServerEvent('ps-drugprocessing:processTempDown', function()
	local src = source
	if not ps.checkDistance(src, vector3(979.59, -144.14, -49.0), 5.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			chemicalvapor = 1,
		},
		give = {
			methtray = 1,
		}
	})
end)

RegisterServerEvent('ps-drugprocessing:processMeth', function()
	local src = source
	if not ps.checkDistance(src, vector3(987.44, -140.5, -49.0), 5.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			methtray = 1,
		},
		give = {
			meth = Config.MethProcessing.Meth,
		}
	})
end)

RegisterServerEvent('ps-drugprocessing:processFailUp', function()
	local src = source
	ps.removeItem(src, "liquidmix", 1)
end)

RegisterServerEvent('ps-drugprocessing:processFailDown', function()
	local src = source
	ps.removeItem(src, "chemicalvapor", 1)
end)
