local QBCore = exports['qb-core']:GetCoreObject()
GlobalState.psCoke = Config.Drugs.coke

local function cooldownCoke(location)
	if Config.Drugs.coke[location] then
		Config.Drugs.coke[location].taken = true
		GlobalState.psCoke = Config.Drugs.coke
		TriggerClientEvent('ps-drugprocessing:removeCocaLeaf', -1, location)
		CreateThread(function()
			Wait(1000 * 10)
			Config.Drugs.coke[location].taken = false
			GlobalState.psCoke = Config.Drugs.coke
			TriggerClientEvent('ps-drugprocessing:addCocaLeaf', -1, location)
		end)
	end
end

RegisterServerEvent('ps-drugprocessing:pickedUpCocaLeaf', function(location)
	local src = source
	if Config.Drugs.coke[location].taken then
		ps.debug(ps.getPlayerName(src) .. " Tried to Get coca leaf at " .. location .. ' but it was set to taken')
		return
	end
	if not ps.checkDistance(src, Config.Drugs.coke[location].loc, 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	if ps.addItem(src, "coca_leaf", 1) then
		cooldownCoke(location)
		ps.notify(src, Lang:t("success.coca_leaf"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processCocaLeaf', function()
	local src = source
	if not ps.checkDistance(src, vector3(1086.2, -3194.9, -38.99), 2.0) then
		return
	end
	ps.craftItem(src, {
		take = {
			coca_leaf = Config.CokeProcessing.CokeLeaf,
		},
		give = {
			coke = Config.CokeProcessing.ProcessCokeLeaf,
		}
	})
end)

RegisterServerEvent('ps-drugprocessing:processCocaPowder', function()
	local src = source
	if not ps.checkDistance(src, vector3(1092.89, -3195.78, -38.99), 2.0) then
		return
	end
	ps.craftItem(src, {
		take = {
			coke = Config.CokeProcessing.Coke,
			bakingsoda = Config.CokeProcessing.BakingSoda,
		},
		give = {
			cokepowder = Config.CokeProcessing.CokePowder,
		}
	})
end)

RegisterServerEvent('ps-drugprocessing:processCocaBrick', function()
	local src = source
    if not ps.checkDistance(src, vector3(1100.51, -3199.46, -38.93), 2.0) then
		return
	end
	ps.craftItem(src, {
		take = {
			coke_small_brick = Config.CokeProcessing.SmallBrick,
		},
		give = {
			coke_brick = Config.CokeProcessing.LargeBrick,
		}
	})
end)
