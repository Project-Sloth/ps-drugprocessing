
local SulfuricAcidBarrels = {}


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(SulfuricAcidBarrels) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

local function spawnTargets()
	for k, v in pairs(GlobalState.psSulfuric) do
		if not v.taken then
			SulfuricAcidBarrels[k] = CreateObjectNoOffset(GetHashKey(v.model), v.loc.x, v.loc.y, v.loc.z, false, false, false)
			SetEntityHeading(SulfuricAcidBarrels[k], v.heading)
			SetEntityAsMissionEntity(SulfuricAcidBarrels[k], true, true)
			FreezeEntityPosition(SulfuricAcidBarrels[k], true)
			ps.entityTarget(SulfuricAcidBarrels[k], {
				{
					icon = "fas fa-vials",
					label = Lang:t("target.sulfuric_acid"),
					action = function()
						if not ps.progressbar(Lang:t("progressbar.processing"), 5000, 'uncuff') then return end
						TriggerServerEvent('ps-drugprocessing:pickedUpSulfuricAcid', k)
					end,
				},
			})
		end
	end
end

spawnTargets()

RegisterNetEvent('ps-drugprocessing:removeSulfuricAcid', function(location)
	if SulfuricAcidBarrels[location] then
		SetEntityAsMissionEntity(SulfuricAcidBarrels[location], false, true)
		DeleteObject(SulfuricAcidBarrels[location])
	end
end)

RegisterNetEvent('ps-drugprocessing:addSulfuricAcid', function(location)
	local model = GetHashKey(GlobalState.psSulfuric[location].model)
	ps.requestModel(model)
	SulfuricAcidBarrels[location] = CreateObjectNoOffset(model, GlobalState.psSulfuric[location].loc.x, GlobalState.psSulfuric[location].loc.y, GlobalState.psSulfuric[location].loc.z, false, false, false)
	SetEntityHeading(SulfuricAcidBarrels[location], GlobalState.psSulfuric[location].heading)
	SetEntityAsMissionEntity(SulfuricAcidBarrels[location], true, true)
	FreezeEntityPosition(SulfuricAcidBarrels[location], true)
	ps.entityTarget(SulfuricAcidBarrels[location], {
		{
			icon = "fas fa-vials",
			label = Lang:t("target.sulfuric_acid"),
			action = function()
				if not ps.progressbar(Lang:t("progressbar.processing"), 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:pickedUpSulfuricAcid', location)
			end,
		},
	})
end)