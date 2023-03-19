local spawnedWeeds = 0
local weedPlants = {}
local isPickingUp, isProcessing, inWeedField = false, false, false
local QBCore = exports['qb-core']:GetCoreObject()

local function LoadAnimationDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end

local function OpenDoorAnimation()
    local ped = PlayerPedId()
    LoadAnimationDict("anim@heists@keycard@") 
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(400)
    ClearPedTasks(ped)
end

local function EnterWWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
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
    OpenDoorAnimation()
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

local function ValidateWeedCoord(plantCoord)
	local validate = true
	if spawnedWeeds > 0 then
		for _, v in pairs(weedPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inWeedField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZWeed(x, y)
	local groundCheckHeights = { 50, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 53.85
end

local function GenerateWeedCoords()
	while true do
		Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

local function SpawnWeedPlants()
	local model = `mw_weed_plant`
	while spawnedWeeds < 15 do
		Wait(0)
		local weedCoords = GenerateWeedCoords()
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(100)
		end
		local obj = CreateObject(model, weedCoords.x, weedCoords.y, weedCoords.z, false, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		weedPlants[#weedPlants+1] = obj
		spawnedWeeds += 1
	end
	SetModelAsNoLongerNeeded(model)
end

local function RollJoint()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.rolling_joint"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:rollJoint')
		local timeLeft = Config.Delays.WeedProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
		end
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end, function()
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end)
end

local function BagSkunk()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.bagging_skunk"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:bagskunk')
		local timeLeft = Config.Delays.WeedProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
		end
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end, function()
		ClearPedTasks(PlayerPedId())
		isProcessing = false
	end)
end

local function ProcessWeed()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processCannabis')
		local timeLeft = Config.Delays.WeedProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.WeedProcessing.coords) > 4 then
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

RegisterNetEvent("ps-drugprocessing:processWeed",function()
	QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result.ret then
			ProcessWeed()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end,{cannabis = 1})
end)

RegisterNetEvent('ps-drugprocessing:EnterWWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.WeedLab["enter"].coords.x, Config.WeedLab["enter"].coords.y, Config.WeedLab["enter"].coords.z))
    if dist < 2 then
		if Config.KeyRequired then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result.ret then
					EnterWWarehouse()
				else
					QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
				end
			end, {weedkey=1})
		else
			EnterWWarehouse()
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ExitWWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.WeedLab["exit"].coords.x, Config.WeedLab["exit"].coords.y, Config.WeedLab["exit"].coords.z))
    if dist < 2 then
		ExitWWarehouse()
	end
end)

RegisterNetEvent("ps-drugprocessing:pickWeed", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #weedPlants, 1 do
		if #(coords - GetEntityCoords(weedPlants[i])) < 2 then
			nearbyObject, nearbyID = weedPlants[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp then
			isPickingUp = true
			TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
			QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.collecting"), 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				ClearPedTasks(PlayerPedId())
				SetEntityAsMissionEntity(nearbyObject, false, true)
				DeleteObject(nearbyObject)
				weedPlants[nearbyID] = nil
				spawnedWeeds -= 1
				TriggerServerEvent('ps-drugprocessing:pickedUpCannabis')
				isPickingUp = false
			end, function()
				ClearPedTasks(PlayerPedId())
				isPickingUp = false
			end)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(weedPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:client:rollJoint', function()
    QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result.ret then
			RollJoint()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end, {marijuana = 1})
end)

RegisterNetEvent('ps-drugprocessing:client:bagskunk', function()
    QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
		if result.ret then
			BagSkunk()
		else
			QBCore.Functions.Notify(Lang:t("error.no_item", {item = result.item}))
		end
	end, {marijuana = 1})
end)

CreateThread(function()
	local weedZone = CircleZone:Create(Config.CircleZones.WeedField.coords, 10.0, {
		name = "ps-weedzone",
		debugPoly = false
	})
	weedZone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            inWeedField = true
            SpawnWeedPlants()
        else
            inWeedField = false
        end
    end)
end)
