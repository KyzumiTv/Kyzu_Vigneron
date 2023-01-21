TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



TriggerEvent('esx_phone:registerNumber', 'vigneron', 'alerte vigneron', true, true)



TriggerEvent('esx_society:registerSociety', 'vigneron', 'vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', {type = 'public'})



RegisterServerEvent('Ouvre:vigneron')

AddEventHandler('Ouvre:vigneron', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', 'Annonce', 'Le vigneron est désormais Ouvert~s~!', 'CHAR_LEST_FRANK_CONF', 8)

	end

end)



RegisterServerEvent('Ferme:vigneron')

AddEventHandler('Ferme:vigneron', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', 'Annonce', 'Le vigneron est désormais ~r~Fermer~s~!', 'CHAR_LEST_FRANK_CONF', 8)

	end

end)



RegisterServerEvent('Recru:vigneron')

AddEventHandler('Recru:vigneron', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', 'Annonce', '~y~Recrutement en cours, rendez-vous au vigneron !', 'CHAR_LEST_FRANK_CONF', 8)

	end

end)





RegisterServerEvent('esx_vigneronjob:prendreitems')

AddEventHandler('esx_vigneronjob:prendreitems', function(itemName, count)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	local sourceItem = xPlayer.getInventoryItem(itemName)



	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)

		local inventoryItem = inventory.getItem(itemName)



		if count > 0 and inventoryItem.count >= count then



			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then

				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")

			else

				inventory.removeItem(itemName, count)

				xPlayer.addInventoryItem(itemName, count)

				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)

			end

		else

			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")

		end

	end)

end)





RegisterNetEvent('esx_vigneronjob:stockitem')

AddEventHandler('esx_vigneronjob:stockitem', function(itemName, count)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(source)

	local sourceItem = xPlayer.getInventoryItem(itemName)



	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)

		local inventoryItem = inventory.getItem(itemName)



		-- does the player have enough of the item?

		if sourceItem.count >= count and count > 0 then

			xPlayer.removeInventoryItem(itemName, count)

			inventory.addItem(itemName, count)

			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")

		else

			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")

		end

	end)

end)





ESX.RegisterServerCallback('esx_vigneronjob:inventairejoueur', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	local items   = xPlayer.inventory



	cb({items = items})

end)



ESX.RegisterServerCallback('esx_vigneronjob:prendreitem', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigneron', function(inventory)

		cb(inventory.items)

	end)

end)





-- Farm



RegisterNetEvent('recolteraisin')

AddEventHandler('recolteraisin', function()

    local item = "raisin"

    local limiteitem = 50

    local xPlayer = ESX.GetPlayerFromId(source)

    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count

    



    if nbitemdansinventaire >= limiteitem then

        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire!")

        recoltepossible = false

    else

        xPlayer.addInventoryItem(item, 1)

        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")

		return

    end

end)



RegisterNetEvent('traitementvin')

AddEventHandler('traitementvin', function()

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)



    local raisin = xPlayer.getInventoryItem('raisin').count

    local vin = xPlayer.getInventoryItem('vin').count



    if vin > 50 then

        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de raisin...')

    elseif raisin < 3 then

        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de raisin pour traiter...')

    else

        xPlayer.removeInventoryItem('raisin', 5)

        xPlayer.addInventoryItem('vin', 1)    

    end

end)





RegisterServerEvent('sellvin')

AddEventHandler('sellvin', function()

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

    local vin = 0



	for i=1, #xPlayer.inventory, 1 do

		local item = xPlayer.inventory[i]



		if item.name == "vin" then

			vin = item.count

		end

	end

    

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)

        societyAccount = account

    end)

    

    if vin > 0 then

        xPlayer.removeInventoryItem('vin', 1)

        xPlayer.addMoney(80)

        societyAccount.addMoney(80)

        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez gagner ~b~80$ pour chaque vente d'un vin")

        TriggerClientEvent('esx:showNotification', xPlayer.source, "La société gagne ~b~80$ pour chaque vente d'un vin")

    else 

        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez plus rien à vendre")

    end

end)



-- Shop 



RegisterNetEvent('Buyvin')

AddEventHandler('Buyvin', function()



    local _source = source

    local xPlayer = ESX.GetPlayerFromId(source)

    local price = 150

    local xMoney = xPlayer.getMoney()



    if xMoney >= price then



        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)

        societyAccount = account

        end)

        xPlayer.removeMoney(price)

        societyAccount.addMoney (price)

        xPlayer.addInventoryItem('vin', 1)

        TriggerClientEvent('esx:showNotification', source, "Achats~w~ effectué !")

    else

         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")

    end

end)