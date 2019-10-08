-- X-Vest Made by Xerxes468893#0001 / Peter Greek
-- to use this you need my "X-Props" script found on the forums 

-------- Vest armour values ----
local lightvestval = 25
local medvestval = 50
local heavyvestval = 75
---- Given Vest armour time ----
local givenlightvesttime = 2500 -- timt to take out
local givenmedvesttime = 5000 -- time to take out
local givenheavyvesttime = 10000 -- time to take out
------- Vest armour time -------
local lightvesttime = 1500 -- timt to take out
local medvesttime = 2500 -- time to take out
local heavyvesttime = 5000 -- time to take out
--------------------------------
local times = 10000 -- (2 mins )  time that you can keep the kest in your hand before it is deleted to save server lag 
local usecooldown = true -- change this to false if you do ont want to use the cooldown 
--------------------------------
local isuse = false -- dont touch 
local cooldown = false -- dont touch 
local given = false -- dont touch 
local isincountdown = false -- dont touch 
--------------------------------


function VehicleInFront()
  local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end



RegisterNetEvent('ARPF:vest')
AddEventHandler('ARPF:vest', function(version,given)
	if version == nil then 
		--exports['mythic_notify']:DoHudText('error', "To use this command do \"/vest light\" or \"/vest medium\" or \"/vest heavy\" you can also use l, m, or h ") -- Add your own notification system here 
	end
    local vehicle = VehicleInFront()
    --print(version.." ARPF-Base-Debug 1")
    light = version  == "light" or version == "l" or version == "L" or version == "LIGHT" or version == "Light" or version == "1"
    med = version  == "medium" or version == "m" or version == "M" or version == "MEDIUM" or version == "Medium" or version == "2"
    heavy = version  == "heavy" or version == "h" or version == "H" or version == "HEAVY" or version == "Heavy" or version == "3"
    if light then 
    	types = "light" 
    elseif med then 
    	types = "medium"
    elseif heavy then 
    	types = "heavy"
    end
    plycoordss = GetEntityCoords(GetPlayerPed(-1))
    if light and cooldown == false and not given then
    	--if exports['ARPM']:checkdutystatus('onduty') or exports['ARPM']:checkdutystatus('BWC') or exports['ARPM']:checkdutystatus('emsduty') then -- add your own job checker here so only cops can use this or make this a usable item for esx
        	--types = light
        	vestgive(types, given)
        --else
		--	exports['mythic_notify']:DoHudText('inform', "You cant use this when not onduty as a cop") -- Add your own notification system here 
		--end
    elseif given then
    	given = true
        vestgive(types, given)
    elseif med or heavy and not given and cooldown == false then
    	if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
       		--if exports['ARPM']:checkdutystatus('onduty') or exports['ARPM']:checkdutystatus('BWC') or exports['ARPM']:checkdutystatus('emsduty') then -- add your own job checker here so only cops can use this or make this a usable item for esx
        		given = false
                if med then 
                    vestwait = 10000
                end
                if heavy then   
                    vestwait = 18000
                end 
                --exports['ARPM']:startUI(vestwait, "Grabing Vest from car.") -- Add your own progress bar system here 
                SetVehicleDoorOpen(vehicle, 0, 1, 1)
                loadAnimDict('anim@narcotics@trash')
                TaskPlayAnim(GetPlayerPed(-1),'anim@narcotics@trash', 'drop_front',0.9, -8, 1900, 49, 3.0, 0, 0, 0)
                    Citizen.Wait(vestwait)
                ClearPedTasks(GetPlayerPed(-1))
                SetVehicleDoorShut(vehicle, 0, 1, 1)
                vestgive(version, given)
            --else
            	--exports['mythic_notify']:DoHudText('inform', "You cant use this when not onduty as a cop")-- Add your own notification system here 
    		--end	
    	else
    		--exports['mythic_notify']:DoHudText('inform', "You need to be looking at a car and near it to use this") -- Add your own notification system here 
    	end
    elseif cooldown == true then
    	--exports['mythic_notify']:DoHudText('inform', "You have to wait "..time.." seconds till you can pull a vest out again!")-- Add your own notification system here 
    	CancelEvent()
    end
end)


RegisterNetEvent('ARPF:vestoff')
AddEventHandler('ARPF:vestoff', function(version,given)
    ped = GetPlayerPed(-1)
    beforeval = GetPedArmour(ped)
    --exports['mythic_notify']:DoHudText('success', beforeval.." vest before ##") -- Add your own notification system here 
    if beforeval >= lightvestval and beforeval < medvestval then 
        types = "light"
    elseif beforeval >= medvestval and beforeval < heavyvestval then
        types = "medium"
    elseif beforeval >= heavyvestval and beforeval < 100 then
        types = "heavy"
    end
    if beforeval > 0 then 
    --exports['ARPM']:startUI(2500, "Taking Off") -- Add your own progress bar system here 
    RequestAnimDict("clothingshirt")
      while not HasAnimDictLoaded("clothingshirt") do
        Citizen.Wait(100)
      end
      TaskPlayAnim(GetPlayerPed(PlayerId()), "clothingshirt", "try_shirt_positive_d", 1.0, -1, -1, 50, 0, 0, 0, 0)
      Citizen.Wait(2500)
      StopAnimTask(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 1.0)
        --exports['mythic_notify']:DoHudText('success', 'You removed your vest') -- Add your own notification system here 
        SetPedArmour(playerPed, 0)
        SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 0)
        vestgive(types, given)
    end
end)


function vestgive(version, given)
TriggerEvent("attach:armor")
--exports['mythic_notify']:DoHudText('inform', "Press \"E\" to put on the vest or press \"G\" to give it to someone else. OR PRESS \"H\" to cancle the event") -- Add your own notification system here 
		print(version.." invest give version")
        light = version  == "light" or version == "l" or version == "L" or version == "LIGHT" or version == "Light" or version == "1"
        med = version  == "medium" or version == "m" or version == "M" or version == "MEDIUM" or version == "Medium" or version == "2"
        heavy = version  == "heavy" or version == "h" or version == "H" or version == "HEAVY" or version == "Heavy" or version == "3"
        if light then 
        	types = "light" 
        elseif med then 
        	types = "medium"
        elseif heavy then 
        	types = "heavy"
        end
    while true do
    	if times > 0 then
    		print(times)
            local plycoordss = GetEntityCoords(GetPlayerPed(-1))
            local vestcoords = GetEntityCoords(attachedPropPerm, false)
            distance = GetDistanceBetweenCoords(plycoordss.x, plycoordss.y, plycoordss.z, vestcoords.x, vestcoords.y, vestcoordsz, false)
            if IsControlPressed(0, 38) and distance <= 3 then
                addarmour(types, given)
                    if usecooldown == true then 
                        cooldown = true
                    end
                break
            elseif IsControlPressed(0, 47) and distance <= 4 then
                closestplayer, distance2 = GetClosestPlayer()
                if distance2 <= 5 then  
                    TriggerEvent("disabledWeapons",false)
                    TriggerEvent("destroyPropPerm")
                    print("given")
                    givento = true
                    otherperson = GetPlayerServerId(closestplayer)
                    TriggerServerEvent("Xvest:givevesttoserver", otherperson,  types, givento)
                    givento = false
                    given = false
                    break
                end
            elseif IsControlPressed(0, 74) then
               	TriggerEvent("disabledWeapons",false)
                TriggerEvent("destroyPropPerm")
               	break
            end
        else
        	--exports['mythic_notify']:DoHudText('inform', "Time ran out and your vest was removed") -- Add your own notification system here 
            TriggerEvent("disabledWeapons",false)
            TriggerEvent("destroyPropPerm")
           	break  
        end
            times = times - 2 
        Citizen.Wait(0)
    end
    CancelEvent()
end

function addarmour(version, given)
    light = version  == "light" or version == "l" or version == "L" or version == "LIGHT" or version == "Light" or version == "1"
    med = version  == "medium" or version == "m" or version == "M" or version == "MEDIUM" or version == "Medium" or version == "2"
    heavy = version  == "heavy" or version == "h" or version == "H" or version == "HEAVY" or version == "Heavy" or version == "3"
    if given then 
        if light then
            waittime = givenlightvesttime -- times take longer if the vest is given to you
            ammount = lightvestval
        elseif med then
            waittime = givenmedvesttime -- times take longer if the vest is given to you
            ammount = medvestval
        elseif heavy then
            waittime = givenheavyvesttime -- times take longer if the vest is given to you
            ammount = heavyvestval
        end
    elseif given == false or given == nil then 
        if light then
            waittime = lightvesttime
            ammount = lightvestval
        elseif med then 
            waittime = medvesttime
            ammount = medvestval
        elseif heavy then
            waittime = heavyvesttime
            ammount = heavyvestval
        end
    end
    playerPed = GetPlayerPed(-1)
    --exports['ARPM']:startUI(waittime, "Putting on Vest") -- Add your own progress bar system here 
    RequestAnimDict("clothingshirt")
    while not HasAnimDictLoaded("clothingshirt") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(GetPlayerPed(PlayerId()), "clothingshirt", "try_shirt_positive_d", 1.0, -1, -1, 50, 0, 0, 0, 0) -- mp_clothing@female@shirt  try_shirt_base    try_shirt_positive_a
        Citizen.Wait(waittime)
    SetPedArmour(playerPed, ammount) 
    TriggerEvent("disabledWeapons",false)
    TriggerEvent("destroyPropPerm")
    StopAnimTask(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 1.0)
    SetPedComponentVariation(GetPlayerPed(-1), 9, 27, 5, 0)
    --exports['mythic_notify']:DoHudText('success', 'You put on your vest') -- Add your own notification system here 
    --local isues = false
    if usecooldown == true then 
        cooldown = true
    end
end



cooldownsecs = 210
cooldownupdate = true

Citizen.CreateThread(function()
    while true do
        Wait(900)
        playerPed = GetPlayerPed(-1)
        if playerPed then
            if cooldown == true then
                if time > 0 then
                    if cooldownupdate and time == math.ceil(cooldownsecs / 4) then
                        --exports['mythic_notify']:DoHudText('inform', "You'll be able to use a vest in " .. time .. " seconds!") -- Add your own notification system here 
                    end
                    if cooldownupdate and time == 10 then
                        PlaySoundFrontend(-1, "10S","MP_MISSION_COUNTDOWN_SOUNDSET", 0) -- this will play a count down sound when it is 10 seconds left 
                        --exports['mythic_notify']:DoHudText('inform', "You'll be able to use a vest in " .. time .. " seconds!") -- Add your own notification system here 
                    end
                    time = time - 1
                else
                    cooldown = false
                end
            else
                time = cooldownsecs
            end
        end
    end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
function GetClosestPlayer()
  local players = GetPlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then

    for index,value in ipairs(players) do
      local target = GetPlayerPed(value)
      if(target ~= ply) then
        local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
        local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
          closestPlayer = value
          closestDistance = distance
        end
      end
    end
    
    return closestPlayer, closestDistance

  else
    --TriggerEvent("DoShortHudText","Inside Vehicle.",2)
  end

end








