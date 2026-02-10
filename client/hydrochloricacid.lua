local Chemicals = {}

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(Chemicals) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

local function spawnTargets()
	for k, v in pairs (GlobalState.psHydro) do
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
						TriggerServerEvent('ps-drugprocessing:pickedUpHydrochloricAcid', k)
					end,
				},
			})
		end
	end
end

spawnTargets()

RegisterNetEvent('ps-drugprocessing:removeHydrochloricAcid', function(location)
	if Chemicals[location] then
		SetEntityAsMissionEntity(Chemicals[location], false, true)
		DeleteObject(Chemicals[location])
	end
end)

RegisterNetEvent('ps-drugprocessing:addHydrochloricAcid', function(location)
	local model = GetHashKey(GlobalState.psHydro[location].model)
	ps.requestModel(model)
	Chemicals[location] = CreateObject(model, GlobalState.psHydro[location].loc.x, GlobalState.psHydro[location].loc.y, GlobalState.psHydro[location].loc.z, false, true, false)
	PlaceObjectOnGroundProperly(Chemicals[location])
	FreezeEntityPosition(Chemicals[location], true)
	ps.entityTarget(Chemicals[location], {
		{
			icon = "fas fa-vials",
			label = Lang:t("target.chemicals"),
			action = function()
				if not ps.progressbar(Lang:t("progressbar.processing"), 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:pickedUpHydrochloricAcid', location)
			end,
		},
	})
end)