local QBCore = exports['qb-core']:GetCoreObject()

local spawnedCocaLeaf = 0
local CocaPlants = {}
local isPickingUp, isProcessing, CWarehouse = false, false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeField.coords, true) < 50 then
			SpawnCocaPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ProcessCocaFarm')
AddEventHandler('ps-drugprocessing:ProcessCocaFarm', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeProcessing.coords, true) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result then
					print('You have this item SA')
					hasitem1 = true
				else
					QBCore.Functions.Notify('You need Coca Leafs!', 'error')
				end
			end, 'coca_leaf')
			Citizen.Wait(1000) -- BUFFER
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result and hasitem1 then
					print('You have this item HA')
					ProcessCoke()
				else
					QBCore.Functions.Notify('You need scissors to do this!', 'error')
				end
			end, 'trimming_scissors')
		end
	end
end)

RegisterNetEvent('ps-drugprocessing:ProcessCocaPowder')
AddEventHandler('ps-drugprocessing:ProcessCocaPowder', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	local amount = 10
	local amount2 = 5
	
	if GetDistanceBetweenCoords(coords, Config.CircleZones.CokePowder.coords, true) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result then
					print('You have this item SA')
					hasitem1 = true
				end
			end, 'coke', 10)
			Citizen.Wait(1000)
			if hasitem1 == true then
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					if result then
						print('You have this item SA')
						hasitem2 = true
					end
				end, 'bakingsoda', 5)
				Citizen.Wait(1000) -- BUFFER
				if hasitem2 == true then
					QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
						if result and hasitem2 then
							print('You have this item HA')
							CutCokePowder()
							hasitem1 = false
							hasitem2 = false	
						end
					end, 'finescale')
				else
					QBCore.Functions.Notify('You need ' ..amount2.. ' Baking Soda' , 'error')
					Citizen.Wait(1000)
					QBCore.Functions.Notify('You need Baking Soda to do this!', 'error')
				end
			else
				QBCore.Functions.Notify('You need ' ..amount.. ' Piles of Cocaine' , 'error')
				Citizen.Wait(1000)
				QBCore.Functions.Notify('Get The Right Items and Come Back', 'error')
			end
		end
	else
		QBCore.Functions.Notify('You are already processing something', 'error')
	end
end)

RegisterNetEvent('ps-drugprocessing:ProcessBricks')
AddEventHandler('ps-drugprocessing:ProcessBricks', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	local amount = 4
	
	if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeBrick.coords, true) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
				if result then
					print('You have this item SA')
					hasitem1 = true
				end
			end, 'coke_small_brick', 4)
			Citizen.Wait(1000)
			if hasitem1 == true then
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					if result and hasitem1 then
						print('You have this item HA')
						ProcessBricks()
						hasitem1 = false
					end
				end, 'finescale')
			else
				QBCore.Functions.Notify('You need ' ..amount.. ' Small Bricks' , 'error')
				Citizen.Wait(1000)
				QBCore.Functions.Notify('Get The Right Items and Come Back', 'error')
			end
		end
	else
		QBCore.Functions.Notify('You are already processing something', 'error')
	end
end)

RegisterNetEvent('ps-drugprocessing:EnterCWarehouse')
AddEventHandler('ps-drugprocessing:EnterCWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.CokeLab["enter"].coords.x, Config.CokeLab["enter"].coords.y, Config.CokeLab["enter"].coords.z))
    if dist < 2 then
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
			if result then
				print('You have the key')
				EnterCWarehouse()
				print('Entering Warehouse')
			else
				print('No Key Stupid')
				QBCore.Functions.Notify('You lack the required items', 'error')
			end
		end, 'cocainekey')
	end
end)

RegisterNetEvent('ps-drugprocessing:ExitCWarehouse')
AddEventHandler('ps-drugprocessing:ExitCWarehouse', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.CokeLab["exit"].coords.x, Config.CokeLab["exit"].coords.y, Config.CokeLab["exit"].coords.z))
    if dist < 2 then
		ExitCWarehouse()
		print('Exiting Warehouse')
	end
end)

function EnterCWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    CWarehouse = true
    Citizen.Wait(500)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    SetEntityCoords(ped, Config.CokeLab["exit"].coords.x, Config.CokeLab["exit"].coords.y, Config.CokeLab["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.CokeLab["exit"].coords.w)
    Citizen.Wait(1000)
    DoScreenFadeIn(250)
end

function ExitCWarehouse()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    CWarehouse = true
    Citizen.Wait(500)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    SetEntityCoords(ped, Config.CokeLab["enter"].coords.x, Config.CokeLab["enter"].coords.y, Config.CokeLab["enter"].coords.z - 0.98)
    SetEntityHeading(ped, Config.CokeLab["enter"].coords.w)
    Citizen.Wait(1000)
    DoScreenFadeIn(250)
	CWarehouse = false
end



function ProcessCoke()
	isProcessing = true
	local playerPed = PlayerPedId()
	
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Processing Leaves...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processCocaLeaf')

		local timeLeft = Config.Delays.CokeProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.CokeProcessing.coords, false) > 4 then
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)
	isProcessing = false
end

function CutCokePowder()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Cutting Cocaine...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processCocaPowder')

		local timeLeft = Config.Delays.CokeProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.CokeProcessing.coords, false) > 4 then
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)

	isProcessing = false
end

function ProcessBricks()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)

	QBCore.Functions.Progressbar("search_register", "Bricking Up Cocaine...", 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	TriggerServerEvent('ps-drugprocessing:processCocaBrick')

		local timeLeft = Config.Delays.CokeProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.CokeBrick.coords, false) > 4 then
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end)

	isProcessing = false
end


RegisterNetEvent('ps-drugprocessing:pickCocaLeaves')
AddEventHandler('ps-drugprocessing:pickCocaLeaves', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #CocaPlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(CocaPlants[i]), false) < 1 then
			nearbyObject, nearbyID = CocaPlants[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then

		if not isPickingUp then
			isPickingUp = true
			TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

			QBCore.Functions.Progressbar("search_register", "Picking cocaine leaves..", 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				ClearPedTasks(PlayerPedId())
				SetEntityAsMissionEntity(nearbyObject, false, true)
				DeleteObject(nearbyObject)

				table.remove(CocaPlants, nearbyID)
				spawnedCocaLeaf = spawnedCocaLeaf - 1

				TriggerServerEvent('ps-drugprocessing:pickedUpCocaLeaf')

			end, function()
				ClearPedTasks(PlayerPedId())
			end)

			isPickingUp = false
		end
	else
		Citizen.Wait(500)
	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(CocaPlants) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

function SpawnCocaPlants()
	while spawnedCocaLeaf < 15 do
		Citizen.Wait(0)
		local weedCoords = GenerateCocaLeafCoords()
		RequestModel(`mw_coke_plant`)
		while not HasModelLoaded(`mw_coke_plant`) do
			Wait(100)
		end
		local obj = CreateObject(`mw_coke_plant`, weedCoords.x, weedCoords.y, weedCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(CocaPlants, obj)
		spawnedCocaLeaf = spawnedCocaLeaf + 1
	end
end

function ValidateCocaLeafCoord(plantCoord)
	if spawnedCocaLeaf > 0 then
		local validate = true

		for k, v in pairs(CocaPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CokeField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCocaLeafCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)

		weedCoordX = Config.CircleZones.CokeField.coords.x + modX
		weedCoordY = Config.CircleZones.CokeField.coords.y + modY

		local coordZ = GetCoordZCoke(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateCocaLeafCoord(coord) then
			return coord
		end
	end
end

function GetCoordZCoke(x, y)
	local groundCheckHeights = { 1.0, 25.0, 50.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 77
end

function LoadAnimationDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function OpenDoorAnimation()
    local ped = PlayerPedId()
    LoadAnimationDict("anim@heists@keycard@") 
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Citizen.Wait(400)
    ClearPedTasks(ped)
end


RegisterCommand('propfix', function()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end)
