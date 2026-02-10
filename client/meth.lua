
local function EnterMethlab()
    local ped = PlayerPedId()
    ps.playEmote('openDoor')
    Methlab = true
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.MethLab["exit"].coords.x, Config.MethLab["exit"].coords.y, Config.MethLab["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.MethLab["exit"].coords.w)
    Wait(1000)
    DoScreenFadeIn(250)
end

local function ExitMethlab()
    local ped = PlayerPedId()
	ps.playEmote('openDoor')
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.MethLab["enter"].coords.x, Config.MethLab["enter"].coords.y, Config.MethLab["enter"].coords.z - 0.98)
    SetEntityHeading(ped, Config.MethLab["enter"].coords.w)
    Methlab = false
    Wait(1000)
    DoScreenFadeIn(250)
end

ps.boxTarget('processChemicals', vector3(978.22, -147.1, -48.53), {
	length = 1.2,
	width = 0.5,
	height = 0.5,
	rotation = 354.0,
}, {
	{
		icon = "fas fa-temperature-full",
		label = Lang:t("target.methtempup"),
		action = function()
			if not ps.progressbar(Lang:t("progressbar.mixing"), 15000, 'uncuff') then return end
			TriggerEvent('ps-drugprocessing:processChemicals')
		end,
	},
})

ps.boxTarget('ChangeTempUp', vector3(982.56, -145.59, -49.0), {
	length = 1.2,
	width = 0.5,
	height = 0.5,
	rotation = 354.0,
}, {
	{
		icon = "fas fa-temperature-full",
		label = Lang:t("target.methtempup"),
		action = function()
			if not ps.minigame('ps-circle', {amount = 2, speed = 4}) then 
				TriggerServerEvent('ps-drugprocessing:processFailUp')
				return
			end
			if not ps.progressbar(Lang:t("progressbar.temp_up"), 15000, 'uncuff') then return end
			TriggerEvent('ps-drugprocessing:processTempUp')
		end,
	},
})
ps.boxTarget('ChangeTempDown', vector3(979.59, -144.14, -49.0), {
	length = 1.2,
	width = 0.5,
	height = 0.5,
	rotation = 354.0,
}, {
	{
		icon = "fas fa-temperature-empty",
		label = Lang:t("target.methtempdown"),
		action = function()
			if not ps.minigame('ps-circle', {amount = 2, speed = 4}) then
				TriggerServerEvent('ps-drugprocessing:processFailDown')
				return
			end
			if not ps.progressbar(Lang:t("progressbar.temp_down"), 15000, 'uncuff') then return end
			TriggerEvent('ps-drugprocessing:processTempDown')
		end,
	},
})

ps.boxTarget('methProcess', vector3(987.44, -140.5, -49.0), {
	length = 1.0,
	width = 1.0,
	height = 1.0,
	rotation = 180.0,
}, {
	{
		icon = "fas fa-envira",
		label = Lang:t("target.methprocess"),
		action = function()
			if not ps.progressbar(Lang:t("progressbar.packing"), 15000, 'uncuff') then return end
			TriggerEvent('ps-drugprocessing:ProcessProduct')
		end,
	},
})

ps.boxTarget('exitMeth', vector3(969.04, -146.17, -46.4), {
	length = 1.0,
	width = 1.0,
	height = 1.0,
	rotation = 180.0,
}, {
	{
		icon = "fas fa-box",
		label = Lang:t("target.heroinprocess"),
		action = function()
			ExitMethlab()
		end,
	},
})

CreateThread(function()
	local model = 'a_m_m_hillbilly_02'
	ps.requestModel(model)
	local ped = CreatePed(0, model, vector4(-1187.73, -445.27, 43.91, 289.45), false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)
	ps.entityTarget(ped, {
		{
			icon = "fas fa-atom",
			label = Lang:t("target.talk_to_walter"),
			action = function()
				EnterMethlab()
			end,
			canInteract = function()
				if Config.KeyRequired then
					return ps.hasKey('methkey')
				else
					return true
				end
			end,
		}
	})
end)