
local CocaPlants = {}


local function EnterCWarehouse()
    local ped = PlayerPedId()
    ps.playEmote('openDoor')
    CWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.CokeLab["exit"].coords.x, Config.CokeLab["exit"].coords.y, Config.CokeLab["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.CokeLab["exit"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
end

local function ExitCWarehouse()
    local ped = PlayerPedId()
    ps.playEmote('openDoor')
    CWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.CokeLab["enter"].coords.x, Config.CokeLab["enter"].coords.y, Config.CokeLab["enter"].coords.z - 0.98)
    SetEntityHeading(ped, Config.CokeLab["enter"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
	CWarehouse = false
end

-- Target Stuff
local function spawnTargets()
	local model = GetHashKey('a_m_m_mlcrisis_01')
	ps.requestModel(model)
	local ped = CreatePed(0, model, vector4(812.49, -2399.59, 23.66-1, 223.1), false, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	ps.entityTarget(ped, {
		{
			icon = "fas fa-lock",
			label = Lang:t("target.coke_lab"),
			action = function()
				EnterCWarehouse()
			end,
		},
	})
	ps.boxTarget("cokeexit", vector3(1088.56, -3187.02, -38.67), {
		length = 1.0,
		width = 1.0,
		height = 1.0,
		rotation = 223.1,
	}, {
		{
			icon = "fas fa-lock",
            label = Lang:t("target.keypad"),
			action = function()
				ExitCWarehouse()
			end,
		},
	})
	ps.boxTarget('cokeleafproc', vector3(1086.2, -3194.9, -38.99), {
		length = 1.0,
		width = 1.0,
		height = 1.0,
		rotation = 223.1,
	}, {
		{
			icon = "fas fa-leaf",
			label = Lang:t("target.coke_leaf_processing"),
			action = function()
				if not ps.progressbar('Processing Coca Leaf', 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:ProcessCocaFarm')
			end,
		},
	})
	ps.boxTarget('cokepowderproc', vector3(1092.89, -3195.78, -38.99), {
		length = 1.0,
		width = 1.0,
		height = 1.0,
		rotation = 223.1,
	}, {
		{
			icon = "fas fa-weight-scale",
			label = Lang:t("target.cokepowdercut"),
			action = function()
				if not ps.progressbar('Processing Coca Powder', 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:ProcessCocaPowder')
			end,
		},
	})
	ps.boxTarget('cokebricksproc', vector3(1100.51, -3199.46, -38.93), {
		length = 1.0,
		width = 1.0,
		height = 1.0,
		rotation = 223.1,
	}, {
		{
			icon = "fas fa-weight-scale",
			label = Lang:t("target.bagging"),
			action = function()
				if not ps.progressbar('Processing Bricks', 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:processCocaBrick')
			end,
		},
	})
end
spawnTargets()

--- Plant Stuff

CreateThread(function()
	for k,v in pairs (GlobalState.psCoke) do
		if not v.taken then 
			local model = GetHashKey(v.model)
			ps.requestModel(model)
			CocaPlants[k] = CreateObject(model, v.loc.x, v.loc.y, v.loc.z, false, true, false)
			PlaceObjectOnGroundProperly(CocaPlants[k])
			FreezeEntityPosition(CocaPlants[k], true)
			SetEntityAsMissionEntity(CocaPlants[k], true, true)
			ps.entityTarget(CocaPlants[k], {
				{
					icon = "fas fa-seedling",
					label = Lang:t("coke.pick_coca_leaf"),
					action = function()
						if not ps.progressbar('Picking Coca Leaf', 5000, 'uncuff') then return end
						TriggerServerEvent('ps-drugprocessing:pickedUpCocaLeaf', k)
					end,
				},
			})
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:removeCocaLeaf', function(location)
	if CocaPlants[location] then
		SetEntityAsMissionEntity(CocaPlants[location], false, true)
		DeleteObject(CocaPlants[location])
	end
end)

RegisterNetEvent('ps-drugprocessing:addCocaLeaf', function(location)
	local model = GetHashKey(GlobalState.psCoke[location].model)
	ps.requestModel(model)
	CocaPlants[location] = CreateObject(model, GlobalState.psCoke[location].loc.x, GlobalState.psCoke[location].loc.y, GlobalState.psCoke[location].loc.z, false, true, false)
	PlaceObjectOnGroundProperly(CocaPlants[location])
	FreezeEntityPosition(CocaPlants[location], true)
	SetEntityAsMissionEntity(CocaPlants[location], true, true)
	ps.entityTarget(CocaPlants[location], {
		{
			icon = "fas fa-seedling",
			label = Lang:t("coke.pick_coca_leaf"),
			action = function()
				if not ps.progressbar('Picking Coca Leaf', 5000, 'uncuff') then return end
				TriggerServerEvent('ps-drugprocessing:pickedUpCocaLeaf', location)
			end,
		},
	})
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(CocaPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)