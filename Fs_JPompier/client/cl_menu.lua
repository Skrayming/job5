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

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

-- OpenMenu

local AppelTotal = 0
local NomAppel = "~r~Personne"

RegisterNetEvent("EMS:AjoutUnAppel")
AddEventHandler("EMS:AjoutUnAppel", function(Appel)
	AppelTotal = Appel
end)

RegisterNetEvent("EMS:DernierAppel")
AddEventHandler("EMS:DernierAppel", function(Appel)
	NomAppel = Appel
end)

-- MENU FUNCTION --

local open = false 
local mainpompierMenu8 = RageUI.CreateMenu('', 'Sapeurs Pompiers')
local subPompierMenu8 = RageUI.CreateSubMenu(mainpompierMenu8, "", "Annonces")
local subPompierMenu9 = RageUI.CreateSubMenu(mainpompierMenu8, "", "Interaction Citoyen")
local subPompierMenu10 = RageUI.CreateSubMenu(mainpompierMenu8, "", "Information Appel")
local subPompierMenu11 = RageUI.CreateSubMenu(mainpompierMenu8, "", "Intéraction Personelle")
mainpompierMenu8.Display.Header = true 
mainpompierMenu8.Closed = function()
  open = false
end

function OpenMenupompier()
	if open then 
		open = false
		RageUI.Visible(mainpompierMenu8, false)
		return
	else
		open = true 
		RageUI.Visible(mainpompierMenu8, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mainpompierMenu8,function()
			RageUI.Checkbox("Prendre son service", nil, servicepompier, {}, {
                onChecked = function(index, items)
                    servicepompier = true
                    exports['okokNotify']:Alert("Sapeurs Pompiers", "Vous avez pris votre service !", 5000, 'info')
                    TriggerServerEvent('pompier:prisedeservice')
                end,
                onUnChecked = function(index, items)
                    servicepompier = false
                    exports['okokNotify']:Alert("Sapeurs Pompiers", "Vous avez quitter votre service !", 5000, 'info')
                    TriggerServerEvent('pompier:quitteleservice')
                end
            })

			if servicepompier then

            RageUI.Separator("~b~↓ Interaction Citoyen ↓")

            RageUI.Button("Interaction Citoyen", nil, {RightLabel = "→"}, true , {
              onSelected = function()
                end
            }, subPompierMenu9)    

            RageUI.Button("Interaction Personelle", nil, {RightLabel = "→"}, true , {
				onSelected = function()
				end
			}, subPompierMenu11)

            RageUI.Button("Information d'appel", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                end
              }, subPompierMenu10)

            -- RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {
            --     onSelected = function()
            --         amount = KeyboardInput("Montant de la facture",nil,3)
            --         amount = tonumber(amount)
            --         local player, distance = ESX.Game.GetClosestPlayer()
    
            --         if player ~= -1 and distance <= 3.0 then
            
            --         if amount == nil then
            --             ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
            --         else
            --             local playerPed        = GetPlayerPed(-1)
            --             Citizen.Wait(5000)
            --             TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_pompier', ('pompier'), amount)
            --             Citizen.Wait(100)
            --             ESX.ShowNotification("~g~Vous avez bien envoyer la facture")
            --         end
            
            --         else
            --         ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
            --         end
            --     end
            -- });
 
 
            RageUI.Separator("~b~↓ Annonces ↓")
            RageUI.Button("Annonces Pompier", nil, {RightLabel = "→"}, true , {
                  onSelected = function()
                    end
           }, subPompierMenu8)      
           

        end
    end)

    RageUI.IsVisible(subPompierMenu8,function() 

        RageUI.Button("Annonce [~g~Ouvertures]", nil, {RightLabel = "→"}, not codesCooldown1, {
           onSelected = function()
               codesCooldown1 = true 
               TriggerServerEvent('Ouvre:pompier')
               Citizen.SetTimeout(8000, function() codesCooldown1 = false end)
           end
       })

       RageUI.Button("Annonce [~r~Fermetures]", nil, {RightLabel = "→"}, not codesCooldown2, {
           onSelected = function()
               codesCooldown2 = true 
               TriggerServerEvent('Ferme:pompier')
               Citizen.SetTimeout(8000, function() codesCooldown2 = false end)
           end
       })

       RageUI.Button("Message [~o~Personnalisé]", nil, {RightLabel = "→"}, not codesCooldown4 , {
           onSelected = function()
               codesCooldown4 = true 
               local te = KeyboardInput("Message", "", 100)
               ExecuteCommand("sap " ..te)
               Citizen.SetTimeout(8000, function() codesCooldown4 = false end)
           end
       })

   end)

   RageUI.IsVisible(subPompierMenu9,function() 

    RageUI.Button("Réanimer la Personne", nil, {RightLabel = "→"}, true , {
        onSelected = function()
            revivePlayer(closestPlayer)    
        end
        })

        RageUI.Button("Soigner une petite blessure", nil, {RightLabel = "→"}, true , {
            onSelected = function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 1.0 then
                    -- ESX.ShowNotification('Aucune Personne à Proximité')
                    exports['okokNotify']:Alert("Sapeurs Pompiers", "Aucune Personne à Proximité", 5000, 'error')
                else
                    ESX.TriggerServerCallback('esx_pompierjob:getItemAmount', function(quantity)
                        if quantity > 0 then
                            local closestPlayerPed = GetPlayerPed(closestPlayer)
                            local health = GetEntityHealth(closestPlayerPed)
        
                            if health > 0 then
                                local playerPed = PlayerPedId()
        
                                IsBusy = true
                                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                Citizen.Wait(10000)
                                ClearPedTasks(playerPed)
        
                                TriggerServerEvent('esx_pompierjob:removeItem', 'bandage')
                                TriggerServerEvent('esx_pompierjob:heal', GetPlayerServerId(closestPlayer), 'small')
                                ESX.ShowNotification('vous avez soigné ~y~%s~s~', GetPlayerName(closestPlayer))
                                IsBusy = false
                            else
                                -- ESX.ShowNotification('Cette personne est inconsciente!')
                                exports['okokNotify']:Alert("Sapeurs Pompiers", "Cette personne est inconsciente", 5000, 'info')
                            end
                        else
                            -- ESX.ShowNotification('Vous n\'avez pas de ~b~bandage~s~.')
                            exports['okokNotify']:Alert("Sapeurs Pompiers", "Vous n\'avez pas de bandage", 5000, 'info')
                        end
                    end, 'bandage')
                end
            end
            })

        
    RageUI.Button("Soigner une plus grande blessure", nil, {RightLabel = "→"}, true , {
        onSelected = function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer == -1 or closestDistance > 1.0 then
                -- ESX.ShowNotification('Aucune Personne à Proximité')
                exports['okokNotify']:Alert("Sapeurs Pompiers", "Aucune Personne à Proximité", 5000, 'error')
            else
                ESX.TriggerServerCallback('esx_pompierjob:getItemAmount', function(quantity)
                    if quantity > 0 then
                        local closestPlayerPed = GetPlayerPed(closestPlayer)
                        local health = GetEntityHealth(closestPlayerPed)

                        if health > 0 then
                            local playerPed = PlayerPedId()

                            IsBusy = true
                            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                            Citizen.Wait(10000)
                            ClearPedTasks(playerPed)

                            TriggerServerEvent('esx_pompierjob:removeItem', 'medikit')
                            TriggerServerEvent('esx_pompierjob:heal', GetPlayerServerId(closestPlayer), 'big')
                            exports['okokNotify']:Alert("Sapeurs Pompiers", "Vous avez soigné "..closestPlayer.."", 5000, 'info')                            IsBusy = false
                        else
                            -- ESX.ShowNotification('Cette personne est inconsciente!')
                            exports['okokNotify']:Alert("Sapeurs Pompiers", "Cette personne est inconsciente", 5000, 'info')
                        end
                    else
                        -- ESX.ShowNotification('Vous n\'avez pas de ~b~kit de soin~s~.')
                        exports['okokNotify']:Alert("Sapeurs Pompiers", "Vous n'avez pas de Kit de soin", 5000, 'info')
                    end
                end, 'medikit')
            end
        end
        })

        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        RageUI.Button("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, {
             onSelected = function() 
          if closestDistance <= 5.0 then 
          TriggerServerEvent('pompier:putInVehicle', GetPlayerServerId(closestPlayer))
      else
        --   ESX.ShowNotification('Aucun joueurs à proximité')
          exports['okokNotify']:Alert("Sapeurs Pompiers", "Aucune Personne à Proximité", 5000, 'error')
      end
  end
  })
  
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→"}, true, {
           onSelected = function() 
           if closestDistance <= 5.0 then 
           TriggerServerEvent('pompier:OutVehicle', GetPlayerServerId(closestPlayer))
       else
        --    ESX.ShowNotification('Aucun joueurs à proximité')
           exports['okokNotify']:Alert("Sapeurs Pompiers", "Aucune Personne à Proximité", 5000, 'error')

       end
    end
    })
  
  end)

RageUI.IsVisible(subPompierMenu11, function()

    RageUI.Button("Props", nil , {RightLabel = "→"}, true , {
        onSelected = function()
        ExecuteCommand("props")
        RageUI.CloseAll()
    end
})

RageUI.Button("Alarme de Départ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("depart")
    RageUI.CloseAll()
end
})

RageUI.Button("Sortir / Ranger la lance à eau", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("ldv")
    -- RageUI.CloseAll()
end
})

RageUI.Button("~b~Sortir le Water monitor ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("watermonitor on")
    -- RageUI.CloseAll()
end
})

RageUI.Button("~r~Ranger le Water monitor ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("watermonitor off")
    -- RageUI.CloseAll()
end
})

RageUI.Button("~b~Config ligne d'approvisionnement ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("supplyline setup")
    -- RageUI.CloseAll()
end
})

RageUI.Button("~r~Retirer ligne d'approvisionnement ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("supplyline remove")
    -- RageUI.CloseAll()
end
})

RageUI.Button("~b~Sortir sac sauvetage aquatique ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'throwbag'
    end
})

RageUI.Button("~b~Sortir un tripod ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'tripod setup'
    end
})

RageUI.Button("~r~Ranger un tripod ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'tripod remove'
    end
})

RageUI.Button("Sortir / Ranger le Robot", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("eod")
    RageUI.CloseAll()
end
})

RageUI.Button("~b~Config stabilisers ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'stabilisers setup'
    end
})

RageUI.Button("~r~Ranger stabilisers ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'stabilisers remove'
    end
})

RageUI.Button("~b~Config cric gonflable ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'jack setup'
    end
})

RageUI.Button("~r~Ranger cric gonflable ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'jack remove'
    end
})

RageUI.Button("~b~Config cale de voiture ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'chock setup'
    end
})

RageUI.Button("~r~Ranger cale de voiture ", nil , {RightLabel = "→"}, true , {
    onSelected = function()
        ExecuteCommand'chock remove'
    end
})

RageUI.Button("Sortir / Ranger la pince de désincarcération", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("spreaders")
end
})

RageUI.Separator("~b~↓ Extras ↓")

RageUI.Button("Extra 1", nil , {RightLabel = "→"}, true , {
    onSelected = function()
    ExecuteCommand("+extra1")
    -- RageUI.CloseAll()
end
})

RageUI.Button("Extra 2", nil , {RightLabel = "→"}, true , {
onSelected = function()
ExecuteCommand("+extra2")
-- RageUI.CloseAll()
end
})

RageUI.Button("Extra 3", nil , {RightLabel = "→"}, true , {
onSelected = function()
ExecuteCommand("+extra3")
-- RageUI.CloseAll()
end
})

RageUI.Button("Extra 4", nil , {RightLabel = "→"}, true , {
onSelected = function()
ExecuteCommand("+extra4")
-- RageUI.CloseAll()
end
})

RageUI.Button("Extra 5", nil , {RightLabel = "→"}, true , {
onSelected = function()
ExecuteCommand("+extra5")
-- RageUI.CloseAll()
end
})

RageUI.Button("Extra 6", nil , {RightLabel = "→"}, true , {
onSelected = function()
ExecuteCommand("+extra6")
-- RageUI.CloseAll()
end
})

RageUI.Button("Extra 7", nil , {RightLabel = "→"}, true , {
onSelected = function()
ExecuteCommand("+extra7")
-- RageUI.CloseAll()
end
})

end)

RageUI.IsVisible(subPompierMenu10, function() 

RageUI.Separator("~b~Dernière prise d'appel : ~s~\n~o~"..NomAppel.." ~w~à pris le dernier appel coma")
RageUI.Separator("")
RageUI.Separator("~b~Total d'appel prise en compte : ~s~\n"..AppelTotal.."")
RageUI.Separator("")


end)
Wait(0)
end
end)
end
end

--- Key

Keys.Register('F6', 'pompier', 'Ouvrir le menu Sapeurs Pompiers', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pompier' then
        OpenMenupompier()
	end
end)

-- Function revive

function revivePlayer(closestPlayer)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 3.0 then
      ESX.ShowNotification(_U('no_players'))
    else
    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
    if qtty > 0 then
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    local health = GetEntityHealth(closestPlayerPed)
    if health == 0 then
    local playerPed = GetPlayerPed(-1)
    Citizen.CreateThread(function()
    ESX.ShowNotification(_U('revive_inprogress'))
    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    Wait(10000)
    ClearPedTasks(playerPed)
    if GetEntityHealth(closestPlayerPed) == 0 then
    TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
    TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
    else
    ESX.ShowNotification(_U('isdead'))
    end
   end)
    else
        ESX.ShowNotification(_U('unconscious'))
    end
     else
    ESX.ShowNotification(_U('not_enough_medikit'))
    end
   end, 'medikit')
end
end

--- Blips

local pos = vector3(1198.5393066406, -1459.6290283203, 34.904991149902)
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(pos)

	SetBlipSprite (blip, 436)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 1)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Sapeurs Pompiers')
	EndTextCommandSetBlipName(blip)
end)


