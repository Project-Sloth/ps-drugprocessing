local isPickingUp, isProcessing = false, false
local QBCore = exports['qb-core']:GetCoreObject()

local function Processlsd()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:Processlsd')

		local timeLeft = Config.Delays.lsdProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.lsdProcessing.coords) > 5 then
				QBCore.Functions.Notify(Lang:t("error.too_far"))
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

local function Processthionylchloride()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processThionylChloride')
		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.thionylchlorideProcessing.coords) > 5 then
				QBCore.Functions.Notify(Lang:t("error.too_far"))
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(playerPed)
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
	end)
end

RegisterNetEvent("ps-drugprocessing:processlsd", function ()
	QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result then
			Processlsd()
		else
			QBCore.Functions.Notify(Lang:t("error.not_all_items"), 'error')
		end
	end, {lsa = 1, thionyl_chloride = 1})
end)

RegisterNetEvent('ps-drugprocessing:processingThiChlo', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if #(coords-Config.CircleZones.thionylchlorideProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result then
					Processthionylchloride()
				else
					QBCore.Functions.Notify(Lang:t("error.not_all_items"), 'error')
				end
			end, {lsa = 1, chemicals = 1})
		end
	end
end)

local tableSpawned = false

local function createLsdTable()
	QBCore.Functions.LoadModel(`v_ret_ml_tablea`)
	local tablepos = Config.CircleZones.lsdProcessing.coords
	ClearAreaOfObjects(tablepos.x, tablepos.y,tablepos.z, 2.0,0)
	LsdTable = CreateObject(`v_ret_ml_tablea`, tablepos.x, tablepos.y,tablepos.z - 1, true, true)
	SetEntityHeading(LsdTable, Config.CircleZones.lsdProcessing.heading)
	tableSpawned = true
end

local function createTTable()
	QBCore.Functions.LoadModel(`v_ret_ml_tablea`)
	local tableTpos = Config.CircleZones.thionylchlorideProcessing.coords
	ClearAreaOfObjects(tableTpos.x, tableTpos.y,tableTpos.z, 2.0,0)
	LsdTable = CreateObject(`v_ret_ml_tablea`, tableTpos.x, tableTpos.y,tableTpos.z - 1, true, true)
	SetEntityHeading(LsdTable, Config.CircleZones.thionylchlorideProcessing.heading)
	tableSpawned = true
end

CreateThread(function()
	local LsdZone = CircleZone:Create(Config.CircleZones.lsdProcessing.coords, 50.0, {
		name = "ps-lsd",
		debugPoly = false
	})
	LsdZone:onPlayerInOut(function(isPointInside)
		if isPointInside then
			if not tableSpawned then
				createLsdTable()
			end
		else
			tableSpawned = false
			DeleteObject(LsdTable)
		end
	end)

	local TZone = CircleZone:Create(Config.CircleZones.thionylchlorideProcessing.coords, 50.0, {
		name = "ps-T",
		debugPoly = false
	})
	TZone:onPlayerInOut(function(isPointInside)
		if isPointInside then
			if not tableSpawned then
				createTTable()
			end
		else
			tableSpawned = false
			DeleteObject(LsdTable)
		end
	end)
end)