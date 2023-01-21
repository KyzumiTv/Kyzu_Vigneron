Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(5000)

	end

end)



--- Récolte de boulont ---



local mainMenu = RageUI.CreateMenu('Récolte', 'Vigneron')



function OpenMenuRecolte()

	if open then 

		open = false

		RageUI.Visible(mainMenu, false)

		return

	else

		open = true 

		RageUI.Visible(mainMenu, true)

		CreateThread(function()

		while open do 

			RageUI.IsVisible(mainMenu,function() 



			RageUI.Button("Commencer la Récolte", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					FreezeEntityPosition(PlayerPedId(), true)

					StartRecolte()

				end

			})



			RageUI.Button("Stopper la Récolte", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					FreezeEntityPosition(PlayerPedId(), false)

					StopRecolte()

				end

			})



			end)

		Wait(0)

		end

	end)

  	end

end



--- FUNCTION RECOLTE ---

function StopRecolte()

    if recoltepossible then

    	recoltepossible = false

    end

end



function StartRecolte()

    if not recoltepossible then

        recoltepossible = true

    while recoltepossible do

        Citizen.Wait(2000)

        TriggerServerEvent('recolteraisin')

    end

    else

        recoltepossible = false

    end

end



----OUVRIR LE MENU------------



local position = {

	{x = -1804.24, y = 2213.69, z = 91.57}

}



Citizen.CreateThread(function()

    while true do



      local wait = 750



        for k in pairs(position) do

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)



            if dist <= 20.0 then

            wait = 0

            DrawMarker(22, 482.62, 6487.40, 30.09, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 76, 175, 80, 255, true, true, p19, true)  



        

            if dist <= 1.0 then

               wait = 0

                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour récolter", 1) 

                if IsControlJustPressed(1,51) then

					OpenMenuRecolte()

            end

        end

    end

    end

    Citizen.Wait(wait)

    end

end

end)



--- Traitement des boulont ---



local mainMenu = RageUI.CreateMenu('Traitement', 'Vigneron')



function OpenMenuTraitement()

	if open then 

		open = false

		RageUI.Visible(mainMenu, false)

		return

	else

		open = true 

		RageUI.Visible(mainMenu, true)

		CreateThread(function()

		while open do 

			RageUI.IsVisible(mainMenu,function() 



			RageUI.Button("Commencer le Traitement", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					FreezeEntityPosition(PlayerPedId(), true)

					StartTraitement()

				end

			})



			RageUI.Button("Stopper le Traitement", nil, {RightLabel = "→"}, true , {

				onSelected = function()

					FreezeEntityPosition(PlayerPedId(), false)

					StopTraitement()

				end

			})



			end)

		Wait(0)

		end

	end)

  	end

end



--- FUNCTION RECOLTE ---



function StopTraitement()

    if traitementpossible then

    	traitementpossible = false

    end

end



function StartTraitement()

    if not traitementpossible then

        traitementpossible = true

    while traitementpossible do

            Citizen.Wait(2000)

            TriggerServerEvent('traitementvin')

    end

    else

        traitementpossible = false

    end

end



----OUVRIR LE MENU------------



local position = {

	{x = -1879.46, y = 2062.53, z = 135.90}  

}



Citizen.CreateThread(function()

    while true do



      local wait = 750



        for k in pairs(position) do

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)



            if dist <= 20.0 then

            wait = 0

            DrawMarker(22, 2343.54, 3142.21, 48.20, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 76, 175, 80, 255, true, true, p19, true)  



        

            if dist <= 1.0 then

               wait = 0

                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour traiter", 1) 

                if IsControlJustPressed(1,51) then

					OpenMenuTraitement()

            end

        end

    end

    end

    Citizen.Wait(wait)

    end

end

end)

