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

local mainMenu6 = RageUI.CreateMenu('Garage', 'Interaction')

mainMenu6.Display.Header = true 

mainMenu6.Closed = function()

  open = false

end



function OpenMenu6()

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

              

              RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→→"}, true , {

                onSelected = function()

                  local playerPed = PlayerPedId()

      

                  if IsPedSittingInAnyVehicle(playerPed) then

                    local vehicle = GetVehiclePedIsIn(playerPed, false)

            

                    if GetPedInVehicleSeat(vehicle, -1) == playerPed then

                      ESX.ShowNotification('La voiture a été mis dans le garage')

                      ESX.Game.DeleteVehicle(vehicle)

                       

                    else

                      ESX.ShowNotification('Mais toi place conducteur, ou sortez de la voiture.')

                    end

                  else

                    local vehicle = ESX.Game.GetVehicleInDirection()

            

                    if DoesEntityExist(vehicle) then

                      ESX.ShowNotification('La voiture à été placer dans le garage.')

                      ESX.Game.DeleteVehicle(vehicle)

            

                    else

                      ESX.ShowNotification('Aucune voitures autours')

                    end

                  end

              end,})

              

              RageUI.Button("Pick-Up", nil, {RightLabel = "→→"}, true , {

                    onSelected = function()

                      local model = GetHashKey("bison3")

                      RequestModel(model)

                      while not HasModelLoaded(model) do Citizen.Wait(10) end

                      local pos = GetEntityCoords(PlayerPedId())

                      local vehicle = CreateVehicle(model, -41.47, -1067.28, 27.61, 63.84947967, true, true)

                      RageUI.CloseAll()

                    end

                })



                RageUI.Button("Van", nil, {RightLabel = "→→"}, true , {

                    onSelected = function()

                      local model = GetHashKey("burrito3")

                      RequestModel(model)

                      while not HasModelLoaded(model) do Citizen.Wait(10) end

                      local pos = GetEntityCoords(PlayerPedId())

                      local vehicle = CreateVehicle(model, -41.47, -1067.28, 27.61, 63.84947967, true, true)

                      RageUI.CloseAll()

                    end

                })



            end)

          Wait(0)

         end

      end)

   end

end



----OUVRIR LE MENU------------



local position = {

	{x = -36.34, y = -1070.08, z = 27.61} 

}



Citizen.CreateThread(function()

    while true do



      local wait = 750



        for k in pairs(position) do

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)



            if dist <= 5.0 then

            wait = 0

            DrawMarker(22, -36.34, -1070.08, 27.61, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 76, 175, 80, 255, true, true, p19, true)  



        

            if dist <= 1.0 then

               wait = 0

                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir", 1) 

                if IsControlJustPressed(1,51) then

                  OpenMenu6()

            end

        end

    end

    end

    Citizen.Wait(wait)

    end

end

end)



--- BLIPS ---



Citizen.CreateThread(function()

 

  local blip = AddBlipForCoord(-1884.79, 2059.01, 140.97)  



  SetBlipSprite (blip, 85) -- Model du blip

  SetBlipDisplay(blip, 4)

  SetBlipScale  (blip, 0.7) -- Taille du blip

  SetBlipColour (blip, 50) -- Couleur du blip

  SetBlipAsShortRange(blip, true)



  BeginTextCommandSetBlipName('STRING')

  AddTextComponentSubstringPlayerName('Vigneron') -- Nom du blip

  EndTextCommandSetBlipName(blip)

end)











