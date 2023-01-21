Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(5000)

	end

end)



--- MENU ---



local open = false 

local mainMenu = RageUI.CreateMenu('Vigneron', 'Shop')

mainMenu.Display.Header = true 

mainMenu.Closed = function()

  open = false

end



--- FUNCTION OPENMENU ---



function ShopVigneron()

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



			RageUI.Button("Vin", nil, {RightLabel = "150$"}, true , {

				onSelected = function()

					TriggerServerEvent('Buyvin')

				end

			})



		end)	

		Wait(0)

	   end

	end)

 end

end



-- Ped



Citizen.CreateThread(function()

    local hash = GetHashKey("a_m_y_beachvesp_01")

    while not HasModelLoaded(hash) do

    RequestModel(hash)

    Wait(20)

    end

    ped = CreatePed("PED_TYPE_CIVMALE", "a_m_y_beachvesp_01",-36.41, -1061.06, 26.61, 70.486007, false, true) -- Position du ped

    SetBlockingOfNonTemporaryEvents(ped, true) -- Fait en sorte que le ped ne réagisse à rien

    FreezeEntityPosition(ped, true) -- Freeze le ped

    SetEntityInvincible(ped, true) -- Le rend invincible

end)



		-------------------------------------------------------------------------------------------------------



local position = {

	{x = -38.14, y = -1060.54, z = 27.61}

}



Citizen.CreateThread(function()

    while true do



      local wait = 750



        for k in pairs(position) do



            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)



            if dist <= 10.0 then

            wait = 0

            DrawMarker(22, -38.14, -1060.54, 27.61, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 76, 175, 80, 255, true, true, p19, true)   



        

            if dist <= 3.0 then

               wait = 0

                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir", 1) 

                if IsControlJustPressed(1,51) then

					ShopVigneron()

            end

        end

    end

    Citizen.Wait(wait)

    end

end

end)



