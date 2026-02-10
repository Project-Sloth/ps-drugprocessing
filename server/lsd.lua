local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugprocessing:Processlsd', function()
	local src = source
	if not ps.checkDistance(src, vector3(2503.53, -427.48, 92.99), 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			lsa = 1,
			thionyl_chloride = 1,
		},
		give = {
			lsd = 1,
		}
	})
end)

RegisterServerEvent('ps-drugprocessing:processThionylChloride', function()
	local src = source
	if not ps.checkDistance(src, vector3(-679.77, 5800.7, 17.33), 2.0) then
		ps.notify(src, Lang:t("error.not_in_range"), "error")
		return
	end
	ps.craftItem(src, {
		take = {
			lsa = 1,
			chemicals = 1,
		},
		give = {
			thionyl_chloride = 1,
		}
	})
end)
