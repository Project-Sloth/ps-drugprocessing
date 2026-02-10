
local weedPlants = {}

-- Lab Stuffs
local function EnterWWarehouse()
    local ped = PlayerPedId()
    ps.playEmote('openDoor')
    WWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.WeedLab["exit"].coords.x, Config.WeedLab["exit"].coords.y, Config.WeedLab["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.WeedLab["exit"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
end

local function ExitWWarehouse()
    local ped = PlayerPedId()
    ps.playEmote('openDoor')
    WWarehouse = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.WeedLab["enter"].coords.x, Config.WeedLab["enter"].coords.y, Config.WeedLab["enter"].coords.z - 0.98)
    SetEntityHeading(ped, Config.WeedLab["enter"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
	WWarehouse = false
end

ps.boxTarget("weedexit", vector3(1066.51, -3183.44, -39.16), {
   length = 1.0,
   width = 1.0,
   height = 1.0,
   rotation = 180.0,
}, {
    {
        icon = "fas fa-lock",
        label = Lang:t("target.keypad"),
		action = function()
			ExitWWarehouse()
		end,
    },
})

ps.boxTarget("weedproces", vector3(1038.37, -3206.06, -38.17), {
   length = 1.0,
   width = 1.0,
   height = 1.0,
   rotation = 165.63,
}, {
	{
        icon = "fas fa-envira",
        label = Lang:t("target.weedproces"),
		action = function()
			if not ps.progressbar('Processing Weed', 5000, 'uncuff') then return end
			TriggerServerEvent('ps-drugprocessing:processCannabis')
		end,
	},
})

local function spawnWeedPed()
	ps.requestModel("mp_f_weed_01")
	local weedPed = CreatePed(4, GetHashKey("mp_f_weed_01"),vector4(102.07, 175.08, 104.59 -1, 159.91), false, true)
	SetBlockingOfNonTemporaryEvents(weedPed, true)
	SetEntityInvincible(weedPed, true)
	FreezeEntityPosition(weedPed, true)
	ps.entityTarget(weedPed, {
		{
			icon = "fas fa-lock",
			label = Lang:t("target.talk_to_charlotte"),
			action = function()
				EnterWWarehouse()
			end,
			canInteract = function()
				if Config.KeyRequired then
					return ps.hasItem('weedkey')
				else
					return true
				end
			end,
		},
	})
end
spawnWeedPed()

-- useable Item Triggers
RegisterNetEvent('ps-drugprocessing:client:rollJoint', function()
   if not  ps.progressbar('Rolling Joint', 5000, 'uncuff') then return end
   TriggerServerEvent('ps-drugprocessing:rollJoint')
end)

RegisterNetEvent('ps-drugprocessing:client:bagskunk', function()
     if not  ps.progressbar('Bagging Skunk', 5000, 'uncuff') then return end
   TriggerServerEvent('ps-drugprocessing:bagskunk')
end)


-- Weed Plant Spawning
CreateThread(function()
	for k, v in pairs(GlobalState.psWeed) do
		if not v.taken then 
			local model = GetHashKey(v.model)
			ps.requestModel(model)
			weedPlants[k] = CreateObject(model, v.loc.x, v.loc.y, v.loc.z, false, true, false)
			PlaceObjectOnGroundProperly(weedPlants[k])
			FreezeEntityPosition(weedPlants[k], true)
			ps.entityTarget(weedPlants[k], {
				{
					icon = "fas fa-seedling",
					label = Lang:t("weed.pick_weed"),
					action = function()
						if weedPlants[k] then
							if not ps.progressbar('Picking Weed', 5000, 'uncuff') then return end
							TriggerServerEvent('ps-drugprocessing:pickedUpCannabis', k)
						end
					end,
				},
			})
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:removeWeed', function(location)
	if weedPlants[location] then
		SetEntityAsMissionEntity(weedPlants[location], false, true)
		DeleteObject(weedPlants[location])
	end
end)

RegisterNetEvent('ps-drugprocessing:addWeed', function(location)
	local model = GetHashKey(GlobalState.psWeed[location].model)
	ps.requestModel(model)
	weedPlants[location] = CreateObject(model, GlobalState.psWeed[location].loc.x, GlobalState.psWeed[location].loc.y, GlobalState.psWeed[location].loc.z, false, true, false)
	PlaceObjectOnGroundProperly(weedPlants[location])
	FreezeEntityPosition(weedPlants[location], true)
	ps.entityTarget(weedPlants[location], {
		{
			icon = "fas fa-seedling",
			label = Lang:t("weed.pick_weed"),
			action = function()
				if weedPlants[location] then
					if not ps.progressbar('Picking Weed', 5000, 'uncuff') then return end
					TriggerServerEvent('ps-drugprocessing:pickedUpCannabis', location)
				end
			end,
		},
	})
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(weedPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)