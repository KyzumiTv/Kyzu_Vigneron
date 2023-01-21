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

local mainMenu8 = RageUI.CreateMenu('Vigneron', 'Interaction')

local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "Annonces", "Interaction")

local subMenu10 = RageUI.CreateSubMenu(mainMenu8, "Farm", "Interaction")

mainMenu8.Display.Header = true 

mainMenu8.Closed = function()

  open = false

end



function OpenMenu8()

	if open then 

		open = false

		RageUI.Visible(mainMenu8, false)

		return

	else

		open = true 

		RageUI.Visible(mainMenu8, true)

		CreateThread(function()

		while open do 

		   RageUI.IsVisible(mainMenu8,function() 



			RageUI.Separator("↓ Annonce ↓")



			RageUI.Button("Annonces Vigneron", nil, {RightLabel = "→"}, true , {

				onSelected = function()

				end

			}, subMenu8)



			RageUI.Separator("↓ Facture ↓")



			RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					OpenBillingMenu2()

                    RageUI.CloseAll()

				end

			})

			



			RageUI.Separator("↓ Farm ↓")



			RageUI.Button("Pour accéder au farms", nil, {RightLabel = "→"}, true , {

				onSelected = function()

				end

			}, subMenu10)



			end)



			RageUI.IsVisible(subMenu8,function() 



			 RageUI.Button("Annonce Ouvertures", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					TriggerServerEvent('Ouvre:vigneron')

				end

			})



			RageUI.Button("Annonce Fermetures", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					TriggerServerEvent('Ferme:vigneron')

				end

			})



			RageUI.Button("Annonce Recrutement", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					TriggerServerEvent('Recru:vigneron')

				end

			})



		   end)



		   RageUI.IsVisible(subMenu10,function() 



			RageUI.Button("Adresse du point de récolte", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					SetNewWaypoint(-1804.24, 2213.69, 91.57) 

				end 

			})



			RageUI.Button("Adresse du point de traitement", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					SetNewWaypoint(-1879.46, 2062.53, 135.90) 

				end

			})



			RageUI.Button("Adresse du point de vente", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					SetNewWaypoint(-157.80, -54.55, 54.38)

				end

			})





			end)



		 Wait(0)

		end

	 end)

  end

end









-- FUNCTION BILLING --



function OpenBillingMenu2()



	ESX.UI.Menu.Open(

	  'dialog', GetCurrentResourceName(), 'billing',

	  {

		title = "Facture"

	  },

	  function(data, menu)

	  

		local amount = tonumber(data.value)

		local player, distance = ESX.Game.GetClosestPlayer()

  

		if player ~= -1 and distance <= 3.0 then

  

		  menu.close()

		  if amount == nil then

			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")

		  else

			local playerPed        = GetPlayerPed(-1)

			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)

			Citizen.Wait(5000)

			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_vigneron', ('vigneron'), amount)

			  Citizen.Wait(100)

			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")

		  end

  

		else

		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")

		end

  

	  end,

	  function(data, menu)

		  menu.close()

	  end

	)

  end



-- OUVERTURE DU MENU --



Keys.Register('F6', 'vigneron', 'Ouvrir le menu vigneron', function()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then

    	OpenMenu8()

	end

end)



