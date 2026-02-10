
local PoppyPlants = {}

-- targets
ps.boxTarget("poppyProccess", vector3(1384.9, -2080.61, 52.21), {
	length = 1.0,
	width = 1.0,
	height = 1.0,
	rotation = 180.0,
}, {
	{
		icon = "fas fa-envira",
		label = Lang:t("target.heroinprocess"),
		action = function()
			if not ps.progressbar('Processing Poppies', 5000, 'uncuff') then return end
			TriggerServerEvent('ps-drugprocessing:processPoppyResin')
		end,
	},
})
-- plant spawning

CreateThread(function()
	for k, v in pairs (GlobalState.psHeroin) do
		if not v.taken then 
			local model = GetHashKey(v.model)
			ps.requestModel(model)
			PoppyPlants[k] = CreateObject(model, v.loc.x, v.loc.y, v.loc.z, false, true, false)
			PlaceObjectOnGroundProperly(PoppyPlants[k])
			FreezeEntityPosition(PoppyPlants[k], true)
			ps.entityTarget(PoppyPlants[k], {
				{
					icon = "fas fa-seedling",
					label = Lang:t("heroin.pick_poppy"),
					action = function()
						if not ps.progressbar('Picking Poppy', 5000, 'uncuff') then return end
						TriggerServerEvent('ps-drugprocessing:pickedUpPoppy', k)
					end,
				},
			})
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:removePoppy', function(location)
	if PoppyPlants[location] then
		SetEntityAsMissionEntity(PoppyPlants[location], false, true)
		DeleteObject(PoppyPlants[location])
	end
end)

RegisterNetEvent('ps-drugprocessing:addPoppy', function(location)
	local model = GetHashKey(GlobalState.psHeroin[location].model)
	ps.requestModel(model)
	PoppyPlants[location] = CreateObject(model, GlobalState.psHeroin[location].loc.x, GlobalState.psHeroin[location].loc.y, GlobalState.psHeroin[location].loc.z, false, true, false)
	PlaceObjectOnGroundProperly(PoppyPlants[location])
	FreezeEntityPosition(PoppyPlants[location], true)
	ps.entityTarget(PoppyPlants[location], {
		{
			icon = "fas fa-seedling",
			label = Lang:t("heroin.pick_poppy"),
			action = function()
				if not ps.progressbar('Picking Poppy', 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:pickedUpPoppy', location)
			end,
		},
	})
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(PoppyPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

