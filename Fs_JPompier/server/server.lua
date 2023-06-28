ESX = nil
local playersHealing, deadPlayers = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'pompier', 'pompier', 'society_pompier', 'society_pompier', 'society_pompier', {type = 'public'})

RegisterServerEvent('Ouvre:pompier')
AddEventHandler('Ouvre:pompier', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		-- TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'pompier', '~r~Annonce', 'Les médecins sont prêts à vous ~g~secourir~s~!', 'CHAR_MICHAEL', 8)
		TriggerClientEvent('okokNotify:Alert', xPlayers[i], "Sapeurs Pompiers", "Les Sapeurs Pompiers sont prêts à vous secourir !", 5000, 'neutral')
	end
end)

RegisterServerEvent('Ferme:pompier')
AddEventHandler('Ferme:pompier', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		-- TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'pompier', '~r~Annonce', 'Plus aucun médecin est en  ~r~ville~s~!', 'CHAR_MICHAEL', 8)
		TriggerClientEvent('okokNotify:Alert', xPlayers[i], "Sapeurs Pompiers", "Plus aucun Sapeurs Pompiers est disponible en ville !", 5000, 'neutral')
	end
end)

RegisterCommand('sap', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "pompier" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            -- TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'pompier', '~r~Annonce', ''..msg..'', 'CHAR_MICHAEL', 0)
			TriggerClientEvent('okokNotify:Alert', xPlayers[i], "Sapeurs Pompiers", ""..msg.."", 5000, 'neutral')
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_MICHAEL', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_MICHAEL', 0)
end
end, false)

---- pompier

RegisterServerEvent('esx_pompierjob:revive')
AddEventHandler('esx_pompierjob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	if xPlayer.job.name == 'pompier' or xPlayer.job.name == 'pompier' then
		local societyAccount = nil
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_pompier', function(account)
			societyAccount = account
		end)
		if societyAccount ~= nil then
			xPlayer.addMoney(Config.ReviveReward)
			TriggerClientEvent('esx_pompierjob:revive', target)
			societyAccount.addMoney(150)
			print('150$ ajouté')
		end
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'pompier' or xPlayer.job.name == 'pompier' then
				TriggerClientEvent('esx_pompierjob:notif', xPlayers[i])
			end
		end
	else
		print(('esx_pompierjob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('pompier:putInVehicle')
AddEventHandler('pompier:putInVehicle', function(target)
  TriggerClientEvent('pompier:putInVehicle', target)
end)

RegisterServerEvent('pompier:OutVehicle')
AddEventHandler('pompier:OutVehicle', function(target)
    TriggerClientEvent('pompier:OutVehicle', target)
end)


ESX.RegisterServerCallback('esx_pompierjob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if EarlyRespawnTimer then
	ESX.RegisterServerCallback('esx_pompierjob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('esx_pompierjob:payFine')
	AddEventHandler('esx_pompierjob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = EarlyRespawnFineAmount

		TriggerClientEvent("esx:showAdvancedNotification", source, "vous avez payé" ..ESX.Math.GroupDigits(fineAmount) " pour être réanimer.")
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end


ESX.RegisterServerCallback('esx_pompierjob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterServerEvent('esx_pompierjob:removeItem')
AddEventHandler('esx_pompierjob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)





ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_pompierjob:useItem', source, 'medikit')

		Citizen.Wait(7000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_pompierjob:useItem', source, 'bandage')

		Citizen.Wait(7000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_pompierjob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print(('esx_pompierjob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_pompierjob:setDeathStatus')
AddEventHandler('esx_pompierjob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		print(('esx_pompierjob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)


-- Notification appel ems pour tout les ems

-- RegisterServerEvent("Server:emsAppel")
-- AddEventHandler("Server:emsAppel", function(coords, id)
-- 	--local xPlayer = ESX.GetPlayerFromId(source)
-- 	local _coords = coords
-- 	local xPlayers	= ESX.GetPlayers()

-- 	for i=1, #xPlayers, 1 do
-- 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
--           if xPlayer.job.name == 'pompier' or xPlayer.job.name == 'pompier' then
--                TriggerClientEvent("AppelemsTropBien", xPlayers[i], _coords, id)
-- 		end
-- 	end
-- end)


-- -- Prise d'appel ems
-- RegisterServerEvent('EMS:PriseAppelServeur')
-- AddEventHandler('EMS:PriseAppelServeur', function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local name = xPlayer.getName(source)
-- 	local xPlayers = ESX.GetPlayers()

-- 	for i = 1, #xPlayers, 1 do
-- 		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
-- 		if thePlayer.job.name == 'pompier' or xPlayer.job.name == 'pompier' then 
-- 			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Secours', '~b~Information', ''..name..'~s~ a pris l\'appel', 'CHAR_MICHAEL', 2)
-- 			TriggerClientEvent('EMS:AppelDejaPris', xPlayers[i], name)
-- 		end
-- 	end
-- end)

-- ESX.RegisterServerCallback('EMS:GetID', function(source, cb)
-- 	local idJoueur = source
-- 	cb(idJoueur)
-- end)

-- local AppelTotal = 0
-- RegisterServerEvent('EMS:AjoutAppelTotalServeur')
-- AddEventHandler('EMS:AjoutAppelTotalServeur', function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local name = xPlayer.getName(source)
-- 	local xPlayers = ESX.GetPlayers()
-- 	AppelTotal = AppelTotal + 1

-- 	for i = 1, #xPlayers, 1 do
-- 		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
-- 		if thePlayer.job.name == 'pompier' or xPlayer.job.name == 'pompier' then
-- 			TriggerClientEvent('EMS:AjoutUnAppel', xPlayers[i], AppelTotal)
-- 		end
-- 	end

-- end)

-- -- Coffre

-- ESX.RegisterServerCallback('pompier:playerinventory', function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local items   = xPlayer.inventory
-- 	local all_items = {}
	
-- 	for k,v in pairs(items) do
-- 		if v.count > 0 then
-- 			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
-- 		end
-- 	end

-- 	cb(all_items)

	
-- end)

-- ESX.RegisterServerCallback('pompier:getStockItems', function(source, cb)
-- 	local all_items = {}
-- 	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pompier', function(inventory)
-- 		for k,v in pairs(inventory.items) do
-- 			if v.count > 0 then
-- 				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
-- 			end
-- 		end

-- 	end)
-- 	cb(all_items)
-- end)

-- RegisterServerEvent('pompier:putStockItems')
-- AddEventHandler('pompier:putStockItems', function(itemName, count)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

-- 	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pompier', function(inventory)
-- 		if item_in_inventory >= count and count > 0 then
-- 			xPlayer.removeInventoryItem(itemName, count)
-- 			inventory.addItem(itemName, count)
-- 			TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Dépot\n~s~- ~g~Item ~s~: "..itemName.."\n~s~- ~o~Quantitée ~s~: "..count.."")
-- 		else
-- 			TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'en avez pas assez sur vous")
-- 		end
-- 	end)
-- end)

-- RegisterServerEvent('pompier:takeStockItems')
-- AddEventHandler('pompier:takeStockItems', function(itemName, count)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pompier', function(inventory)
-- 			xPlayer.addInventoryItem(itemName, count)
-- 			inventory.removeItem(itemName, count)
-- 			TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~r~Retrait\n~s~- ~g~Item ~s~: "..itemName.."\n~s~- ~o~Quantitée ~s~: "..count.."")
-- 	end)
-- end)


-- Pharamacie 


RegisterServerEvent('PharmacyP:giveItem')
AddEventHandler('PharmacyP:giveItem', function(Nom, Item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local qtty = xPlayer.getInventoryItem(Item).count

		if qtty < 10 then
			xPlayer.addInventoryItem(Item, 1)
			-- TriggerClientEvent('esx:showNotification', _source, '- ~g~pompier\n~s~- ~o~Tu as recu des bandages ~o~(+1)')
			TriggerClientEvent('okokNotify:Alert', source, "Sapeurs Pompiers", "Vous avez recu un "..Item.."", 5000, 'success')
		else
			-- TriggerClientEvent('esx:showNotification', _source, "- ~g~pompier\n~s~- ~o~Limite : 10 \n~s~- ~r~Maximum : ~r~"..Item.." atteints")
			TriggerClientEvent('okokNotify:Alert', source, "Sapeurs Pompiers", "Limite de 10 - Maximum de "..Item.." atteints", 5000, 'error')
		end
	end)

--Boss

-- RegisterServerEvent('pompier:withdrawMoney')
-- AddEventHandler('pompier:withdrawMoney', function(society, amount, money_soc)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local src = source
  
-- 	TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
-- 	  if account.money >= tonumber(amount) then
-- 		  xPlayer.addMoney(amount)
-- 		  account.removeMoney(amount)
-- 		  TriggerClientEvent("esx:showNotification", src, "- ~o~Retiré \n~s~- ~g~Somme : "..amount.."$")
-- 	  else
-- 		  TriggerClientEvent("esx:showNotification", src, "- ~r~L'entreprise \n~s~- ~g~Pas assez d'argent")
-- 	  end
-- 	end)
	  
--   end)

-- RegisterServerEvent('pompier:depositMoney')
-- AddEventHandler('pompier:depositMoney', function(society, amount)

-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local money = xPlayer.getMoney()
-- 	local src = source
  
-- 	TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
-- 	  if money >= tonumber(amount) then
-- 		  xPlayer.removeMoney(amount)
-- 		  account.addMoney(amount)
-- 		  TriggerClientEvent("esx:showNotification", src, "- ~o~Déposé \n~s~- ~g~Somme : "..amount.."$")
-- 	  else
-- 		  TriggerClientEvent("esx:showNotification", src, "- ~r~Erreur \n~s~- ~g~Pas assez d'argent")
-- 	  end
-- 	end)
	
-- end)

-- ESX.RegisterServerCallback('pompier:getSocietyMoney', function(source, cb, soc)
-- 	local money = nil
-- 		MySQL.Async.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @society ', {
-- 			['@society'] = soc,
-- 		}, function(data)
-- 			for _,v in pairs(data) do
-- 				money = v.money
-- 			end
-- 			cb(money)
-- 		end)
-- end)

--- Prise de service

function sendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "Sapeurs Pompiers France New Life",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(ConfigWebhookRendezVouspompier, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('pompier:prisedeservice')
AddEventHandler('pompier:prisedeservice', function()
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	sendToDiscordWithSpecialURL("Prise de service",xPlayer.getName().." à prise son service", 16744192, ConfigWebhookRendezVouspompier)
end)

RegisterNetEvent('pompier:quitteleservice')
AddEventHandler('pompier:quitteleservice', function()
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	sendToDiscordWithSpecialURL("Fin de service",xPlayer.getName().." à quitter son service", 16744192, ConfigWebhookRendezVouspompier)
end)

--- Accueil

local function sendToDiscordWithSpecialURL(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Sapeurs Pompiers France New Life",
	            ["icon_url"] = nil,
	            },
	        }
	    }
	PerformHttpRequest(ConfigWebhookRendezVouspompier, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("Rdv:pompierMotif")
AddEventHandler("Rdv:pompierMotif", function(nomprenom, numero, heurerdv, rdvmotif)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ident = xPlayer.getIdentifier()
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end

	if ident == 'steam:11' then--Special character in username just crash the server
	else 
		sendToDiscordWithSpecialURL(16744192, "Nouveau Rendez-Vous\n\n```Nom : "..nomprenom.."\n\nNuméro de Téléphone: "..numero.."\n\nHeure du Rendez Vous : " ..heurerdv.."\n\nMotif du Rendez-vous : " ..rdvmotif.. "\n\n```Date : " .. date.day .. "." .. date.month .. "." .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min " .. date.sec)
	end
end)

RegisterServerEvent('Appel:pompier')
AddEventHandler('Appel:pompier', function()
    
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'pompier' then
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'pompier', '~r~Accueil', 'Un médecin est appelé à l\'accueil !', 'CHAR_MICHAEL', 8)
        end
    end
end)