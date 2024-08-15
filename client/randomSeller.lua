local QBCore = exports['qb-core']:GetCoreObject()
local Location = nil

local SellerInfo = {
    {coords = vector4(1109.16, -2193.15, 30.72, 84.71), itemInfo = {
        {item = 'human_heart', price = 25000},
        {item = 'human_liver', price = 12500},
        {item = 'human_kidneys', price = 7500},
    }, markedbills = true},
}

CreateThread(function()
    while true do
        local loc = GetEntityCoords(PlayerPedId())
        local count = #SellerInfo
        for key, value in pairs(SellerInfo) do
            local dist = #(loc-vector3(value.coords.x, value.coords.y, value.coords.z))
            if dist <= 10 then
                Location = value
            else
                count = count -1
            end
        end
        if count <= 0 then Location = nil end
        Wait(2000)
    end
end)

RegisterNetEvent('angelicxs-randomshop:openMenu', function()
    QBCore.Functions.TriggerCallback('angelicxs-randomshop:getInv', function(inventory)
        local PlyInv = inventory
        local shopMenu = {
            {
                header = "Sellable Items",
                isMenuHeader = true,
            }
        }
        for _, v in pairs(PlyInv) do
            for __, itemInfo in pairs (Location.itemInfo) do
                if v.name == itemInfo.item then
                    shopMenu[#shopMenu + 1] = {
                        header = QBCore.Shared.Items[v.name].label,
                        txt = "Sale Price: $"..tostring(itemInfo.price),
                        params = {
                            event = 'angelicxs-randomshop:sellitems',
                            args = {
                                label = QBCore.Shared.Items[v.name].label,
                                price = itemInfo.price,
                                name = v.name,
                                amount = v.amount
                            }
                        }
                    }
                end
            end
        end
        shopMenu[#shopMenu + 1] = {
            header = "Leave",
            params = {}
        }
        exports['qb-menu']:openMenu(shopMenu)
    end)
end)

RegisterNetEvent('angelicxs-randomshop:sellitems', function(item)
    local sellingItem = exports['qb-input']:ShowInput({
        header = "Offer to Sell "..item.label,
        submitText = "Sell",
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = "MAXIMUM: "..tostring(item.amount)
            }
        }
    })
    if sellingItem then
        if not sellingItem.amount then
            return
        end

        if tonumber(sellingItem.amount) > item.amount then
            QBCore.Functions.Notify("You have do not have that many items to sell.", 'error')
        elseif tonumber(sellingItem.amount) > 0 then
            TriggerServerEvent('angelicxs-randomshop:sellItems', item.name, sellingItem.amount, item.price, Location)
        else
            QBCore.Functions.Notify("You have entered an incorrect amount.", 'error')
        end
    end
end)

------ ADD TO SERVER
-- QBCore.Functions.CreateCallback('angelicxs-randomshop:getInv', function(source, cb)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local inventory = Player.PlayerData.items
--     return cb(inventory)
-- end)

-- RegisterNetEvent('angelicxs-randomshop:sellItems', function(itemName, itemAmount, itemPrice, Location)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local totalPrice = (tonumber(itemAmount) * itemPrice)
--     local playerCoords = GetEntityCoords(GetPlayerPed(src))
--     local dist = #(playerCoords - vector3(Location.coords.x, Location.coords.y, Location.coords.z))
--     if dist > 5 then print("Possible Exploit Attempt Player # "..src) return end
--     if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
--         if Location.markedbills then
--             Player.Functions.AddItem('markedbills', totalPrice)
--         else
--             Player.Functions.AddMoney('cash', totalPrice)
--         end
--         TriggerClientEvent('QBCore:Notify', src, "You have sold "..tostring(itemAmount).." "..QBCore.Shared.Items[itemName].label.." for $ "..tostring(totalPrice),'success')
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
--     else
--         TriggerClientEvent('QBCore:Notify', src, "Not enough items!", 'error')
--     end
--     TriggerClientEvent('angelicxs-randomshop:openMenu', src)
-- end)

-----

local function getVehicleFromVehList(hash)
    for _, v in pairs(QBCore.Shared.Vehicles) do
        if hash == v.hash then
            return v.model
        end
    end
end

RegisterNetEvent('angelicxs-buybackProgram', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= 0 then
        local driver = GetPedInVehicleSeat(veh, -1)
        if driver == ped then
            local plate = QBCore.Functions.GetPlate(veh)
            local props = QBCore.Functions.GetVehicleProperties(veh)
            local hash = props.model
            local vehname = getVehicleFromVehList(hash)
            local price = 0
            if QBCore.Shared.Vehicles[vehname] ~= nil and next(QBCore.Shared.Vehicles[vehname]) ~= nil then
                QBCore.Functions.Notify("Searching for registration information!", 'primary')
                price = QBCore.Shared.Vehicles[vehname]["price"]
                QBCore.Functions.TriggerCallback('angelicxs-buybackProgram:serverAction', function(cb)
                    if cb then
                        DeleteEntity(veh)
                        QBCore.Functions.Notify("You have sold your vehicle back to the government! Amount Recieved: $"..price, 'success')
                    else
                        QBCore.Functions.Notify("You can't sell a vehicle you do not own!", 'error')
                    end
                end, price, plate)

            else
            QBCore.Functions.Notify("Vehicle is not in shared/vehicle.lua!", 'error')
            end
        else
            QBCore.Functions.Notify("You need to be the driver of the vehicle to do this!", 'error')
        end
    else
        QBCore.Functions.Notify("You need to be in a vehicle to do this!", 'error')
    end

end)