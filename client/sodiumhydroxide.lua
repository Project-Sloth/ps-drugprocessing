
local SodiumHydroxideBarrels = {}

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(SodiumHydroxideBarrels) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

local function spawnTargets()
	for k, v in pairs (GlobalState.psSodium) do
		if not v.taken then
			SodiumHydroxideBarrels[k] = CreateObjectNoOffset(GetHashKey(v.model), v.loc.x, v.loc.y, v.loc.z, false, false, false)
			SetEntityHeading(SodiumHydroxideBarrels[k], v.heading)
			SetEntityAsMissionEntity(SodiumHydroxideBarrels[k], true, true)
			FreezeEntityPosition(SodiumHydroxideBarrels[k], true)
			ps.entityTarget(SodiumHydroxideBarrels[k], {
				{
					icon = "fas fa-vials",
					label = Lang:t("target.sodium_hydroxide"),
					action = function()
						if not ps.progressbar(Lang:t("progressbar.processing"), 5000, 'uncuff') then return end
						TriggerServerEvent('ps-drugprocessing:pickedUpSodiumHydroxide', k)
					end,
				},
			})
		end
	end
end

spawnTargets()

RegisterNetEvent('ps-drugprocessing:removeSodiumHydroxide', function(location)
	if SodiumHydroxideBarrels[location] then
		SetEntityAsMissionEntity(SodiumHydroxideBarrels[location], false, true)
		DeleteObject(SodiumHydroxideBarrels[location])
	end
end)

RegisterNetEvent('ps-drugprocessing:addSodiumHydroxide', function(location)
	local model = GetHashKey(GlobalState.psSodium[location].model)
	ps.requestModel(model)
	SodiumHydroxideBarrels[location] = CreateObjectNoOffset(model, GlobalState.psSodium[location].loc.x, GlobalState.psSodium[location].loc.y, GlobalState.psSodium[location].loc.z, false, false, false)
	SetEntityHeading(SodiumHydroxideBarrels[location], GlobalState.psSodium[location].heading)
	SetEntityAsMissionEntity(SodiumHydroxideBarrels[location], true, true)
	FreezeEntityPosition(SodiumHydroxideBarrels[location], true)
	ps.entityTarget(SodiumHydroxideBarrels[location], {
		{
			icon = "fas fa-vials",
			label = Lang:t("target.sodium_hydroxide"),
			action = function()
				if not ps.progressbar(Lang:t("progressbar.processing"), 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:pickedUpSodiumHydroxide', location)
			end,
		},
	})
end)
