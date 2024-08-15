--[[
	Orginal code by roto / mozy
	https://pastebin.com/RKpcmXw7

	Rewrite/port to FiveM 
	by TheIndra
]]

--[[
isAttached = false
attachedEntity = nil

show = false

CreateThread(function()
	AddTextEntry("press_attach_vehicle", "Press ~INPUT_DROP_AMMO~ to pick up this vehicle")

    while true do
        Wait(0)

		if show then
			DisplayHelpTextThisFrame("press_attach_vehicle")
		end

        -- f10 to attach/detach
        if IsControlJustPressed(0, 57) then
			-- if already attached detach
			if isAttached then
				DetachEntity(attachedEntity, true, true)
				
				attachedEntity = nil
				isAttached = false
			else	
				-- get vehicle infront
				local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
				local veh = GetClosestVehicle(pos, 2.0, 0, 70)
				
				-- if vehicle is found
				if veh ~= 0 and IsPedInAnyVehicle(PlayerPedId(), false) then
					local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					
					-- check if player is in forklift
					if GetEntityModel(currentVehicle) == `forklift` then 
						isAttached = true
						show = false
						attachedEntity = veh
						
						-- attach vehicle to forklift, you can change some values
						AttachEntityToEntity(veh, currentVehicle, 3, 0.0, 1.3, -0.09, 0.0, 0, 90.0, false, false, false, false, 2, true)
					end
				end
			end
        end        
    end
end)

CreateThread(function()
	while true do
		-- check every 500ms if helptext should show
		Wait(500)
		
		local player = PlayerPedId()	
		
		-- kinda nasty one-liner
		if not isAttached and IsPedInAnyVehicle(player) and GetEntityModel(GetVehiclePedIsIn(player)) == `forklift` then
			local pos = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
			local veh = GetClosestVehicle(pos, 2.0, 0, 70)
			
			show = (veh ~= 0)
		else show = false end
	end
end)
]]