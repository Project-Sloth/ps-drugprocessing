
local Chemicals = {}
-- Chemical Menu Trigger & Menu Button Triggers --
local function createChemicalMenu()
    local chemMenu = {
        {
            isHeader = true,
            header = Lang:t("menu.chemMenuHeader")
        },
        {
			icon = ps.getImage('hydrochloric_acid'),
            header = Lang:t("items.hydrochloric_acid"),
            txt = Lang:t("menu.chemicals"),
			disabled = not ps.hasItem('chemicals'),
			action = function()
				if not ps.progressbar(Lang:t("progressbar.processing"), 10000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:processHydrochloric_acid')
			end
        },
        {
			icon = ps.getImage('sodium_hydroxide'),
            header = Lang:t("items.sodium_hydroxide"),
            txt = Lang:t("menu.chemicals"),
			disabled = not ps.hasItem('chemicals'),
			action = function()
				if not ps.progressbar(Lang:t("progressbar.processing"), 10000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:processsodium_hydroxide')
			end
		},
        {
			icon = ps.getImage('sulfuric_acid'),
            header = Lang:t("items.sulfuric_acid"),
            txt = Lang:t("menu.chemicals"),
			disabled = not ps.hasItem('chemicals'),
			action = function()
				if not ps.progressbar(Lang:t("progressbar.processing"), 10000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:processprocess_sulfuric_acid')
			end
		},
        {
			icon = ps.getImage('lsa'),
			header = Lang:t("items.lsa"),
            txt = Lang:t("menu.chemicals"),
			disabled = not ps.hasItem('chemicals'),
			action = function()
				if not ps.progressbar(Lang:t("progressbar.processing"), 10000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:process_lsa')
			end
        },
        {
            header = Lang:t("menu.close"),
			txt = Lang:t("menu.closetxt"),
			params = {
                event = exports['qb-menu']:closeMenu(),
            }
        },
    }
    exports['qb-menu']:openMenu(chemMenu)
end
ps.boxTarget('chemmenu', vector3(3535.66, 3661.69, 28.12), {
		length = 1.0,
        width = 1.0,
        rotation = 0,
        height = 1.0,
	}, {
        {
            icon = "fas fa-vials",
            label = Lang:t("target.chemmenu"),
			action = function()
				createChemicalMenu()
			end,
        },
    })

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(Chemicals) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

CreateThread(function()
	for k, v in pairs(GlobalState.psChem) do
		if not v.taken then
			local model = GetHashKey(v.model)
			ps.requestModel(model)
			Chemicals[k] = CreateObject(model, v.loc.x, v.loc.y, v.loc.z, false, true, false)
			PlaceObjectOnGroundProperly(Chemicals[k])
			FreezeEntityPosition(Chemicals[k], true)
			ps.entityTarget(Chemicals[k], {
				{
					icon = "fas fa-vials",
					label = Lang:t("target.chemicals"),
					action = function()
						if not ps.progressbar(Lang:t("progressbar.processing"), 5000, 'uncuff') then return end
						TriggerServerEvent('ps-drugprocessing:pickedUpChemicals', k)
					end,
				},
			})
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:removeChem', function(location)
	if Chemicals[location] then
		SetEntityAsMissionEntity(Chemicals[location], false, true)
		DeleteObject(Chemicals[location])
		Chemicals[location] = nil
	end
end)

RegisterNetEvent('ps-drugprocessing:addChem', function(location)
	local model = GetHashKey(GlobalState.psChem[location].model)
	ps.requestModel(model)
	Chemicals[location] = CreateObject(model, GlobalState.psChem[location].loc.x, GlobalState.psChem[location].loc.y, GlobalState.psChem[location].loc.z, false, true, false)
	PlaceObjectOnGroundProperly(Chemicals[location])
	FreezeEntityPosition(Chemicals[location], true)
	ps.entityTarget(Chemicals[location], {
		{
			icon = "fas fa-vials",
			label = Lang:t("target.chemicals"),
			action = function()
				if not ps.progressbar(Lang:t("progressbar.processing"), 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:pickedUpChemicals', location)
			end,
		},
	})
end)