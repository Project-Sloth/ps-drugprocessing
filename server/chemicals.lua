
GlobalState.psChem = Config.Drugs.chemicals

local function cooldownChems(location)
	if Config.Drugs.chemicals[location] then
		Config.Drugs.chemicals[location].taken = true
		GlobalState.psChem = Config.Drugs.chemicals
		TriggerClientEvent('ps-drugprocessing:removeChem', -1, location)
		CreateThread(function()
			Wait(1000 * 10)
			Config.Drugs.chemicals[location].taken = false
			GlobalState.psChem = Config.Drugs.chemicals
			TriggerClientEvent('ps-drugprocessing:addChem', -1, location)
		end)
	end
end
RegisterServerEvent('ps-drugprocessing:pickedUpChemicals', function(location)
	local src = source
	if Config.Drugs.chemicals[location].taken then
		ps.debug(ps.getPlayerName(src) .. " Tried to Get chemicals at " .. location .. ' but it was set to taken')
		return
	end
	if not ps.checkDistance(src, Config.Drugs.chemicals[location].loc, 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	if ps.addItem(src, "chemicals", 1) then
		cooldownChems(location)
		ps.notify(src, Lang:t("success.chemicals"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processHydrochloric_acid', function()
	local src = source
	local dist = ps.checkDistance(src, vector3(3535.66, 3661.69, 28.12), 2.0)
	if not dist then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			chemicals = 1,
		},
		give = {
			hydrochloric_acid = 1,
		},
	})
end)

RegisterServerEvent('ps-drugprocessing:processsodium_hydroxide', function()
	local src = source
    local dist = ps.checkDistance(src, vector3(3535.66, 3661.69, 28.12), 2.0)
	if not dist then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			chemicals = 1,
		},
		give = {
			sodium_hydroxide = 1,
		},
	})
end)

RegisterServerEvent('ps-drugprocessing:processprocess_sulfuric_acid', function()
	local src = source
    local dist = ps.checkDistance(src, vector3(3535.66, 3661.69, 28.12), 2.0)
	if not dist then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			chemicals = 1,
		},
		give = {
			sulfuric_acid = 1,
		},
	})
end)

RegisterServerEvent('ps-drugprocessing:process_lsa', function()
	local src = source
    local dist = ps.checkDistance(src, vector3(3535.66, 3661.69, 28.12), 2.0)
	if not dist then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			chemicals = 1,
		},
		give = {
			lsa = 1,
		},
	})
	
end)
