Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('', 'Garage')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenMenuGaragepompier()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 

              RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                  if dist4 < 4 then
                      DeleteEntity(veh)
                      RageUI.CloseAll()
                  end
                 end
             })

                for k,v in pairs(Config.AmbuVehiculespompier) do
                RageUI.Button(v.buttoname, nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzone.x, v.spawnzone.y, v.spawnzone.z), 10.0) then
                        ESX.ShowNotification("~g~pompier\n~r~Point de spawn bloquée")
                        else
                        local model = GetHashKey(v.spawnname)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(10) end
                        local ambuveh = CreateVehicle(model, v.spawnzone.x, v.spawnzone.y, v.spawnzone.z, v.headingspawn, true, false)
                        SetVehicleNumberPlateText(ambuveh, "pompier"..math.random(50, 999))
                        SetVehicleFixed(ambuveh)
                        TaskWarpPedIntoVehicle(PlayerPedId(),  ambuveh,  -1)
                        SetVehRadioStation(ambuveh, 0)
                        RageUI.CloseAll()
                        end
                    end
                })


              end
            end)
          Wait(0)
         end
      end)
   end
end


Citizen.CreateThread(function()
  while true do 
      local wait = 750
      if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pompier' then
          for k in pairs(Config.Position.GarageVehicule) do 
              local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
              local pos = Config.Position.GarageVehicule
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

              if dist <= 5.0 then 
                  wait = 0
                  DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
              end

              if dist <= 2.0 then 
                  wait = 0
                  Visual.Subtitle(Config.TextGarageVehicule, 1)
                  if IsControlJustPressed(1,51) then
                      OpenMenuGaragepompier()
                  end
              end
          end
      end
  Citizen.Wait(wait)
  end
end)


-- Garage Helico

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('', 'Garage')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenMenuGarageHelipompier()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 

              RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                  if dist4 < 4 then
                      DeleteEntity(veh)
                      RageUI.CloseAll()
                  end
                    end
                  })

              RageUI.Separator("↓ Véhicules ↓")

                for k,v in pairs(Config.AmbuHelicopompier) do
                RageUI.Button(v.buttonameheli, nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzoneheli.x, v.spawnzoneheli.y, v.spawnzoneheli.z), 10.0) then
                        ESX.ShowNotification("~g~pompier\n~r~Point de spawn bloquée")
                        else
                        local model = GetHashKey(v.spawnnameheli)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(10) end
                        local ambuheli = CreateVehicle(model, v.spawnzoneheli.x, v.spawnzoneheli.y, v.spawnzoneheli.z, v.headingspawnheli, true, false)
                        SetVehicleNumberPlateText(ambuheli, "pompier"..math.random(50, 999))
                        SetVehicleFixed(ambuheli)
                        TaskWarpPedIntoVehicle(PlayerPedId(),  ambuheli,  -1)
                        SetVehRadioStation(ambuheli, 0)
                        RageUI.ClosAll()
                        end
                    end
                })


              end
            end)
          Wait(0)
         end
      end)
   end
end


Citizen.CreateThread(function()
  while true do 
      local wait = 750
      if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pompier' then
          for k in pairs(Config.Position.GarageHeli) do 
              local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
              local pos = Config.Position.GarageHeli
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

              if dist <= 5.0 then 
                  wait = 0
                  DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
              end

              if dist <= 2.0 then 
                  wait = 0
                  Visual.Subtitle(Config.TextGarageHeli, 1)
                  if IsControlJustPressed(1,51) then
                      OpenMenuGarageHelipompier()
                  end
              end
          end
      end
  Citizen.Wait(wait)
  end
end)


Citizen.CreateThread(function()
  local hash = GetHashKey("s_m_m_security_01")
  while not HasModelLoaded(hash) do
  RequestModel(hash)
  Wait(20)
  end
  ped = CreatePed("PED_TYPE_CIVMALE", "s_m_m_security_01", 1191.4600830078, -1482.5570068359, 33.692276000977, 2.93582653999328, false, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  FreezeEntityPosition(ped, true)
  SetEntityInvincible(ped, true)
end)