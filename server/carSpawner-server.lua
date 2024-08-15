local CARConfig = {
    {   
        Model = 'chevelless',
        Coords = vector4(-342.38, -128.61, 46.05, 1.46),
        Invincible = true,
        Frozen = true,
        HardLocked = true,
    },
    {   
        Model = 'mustangbeast',
        Coords = vector4(-336.4, -113.04, 46.04, 30.13),
        Invincible = true,
        Frozen = true,
    }, 
    {   
        Model = 'vanquishhycade',
        Coords = vector4(-326.17, -117.5, 46.5, 158.75),
        Invincible = true,
        Frozen = true,
    }, 
    {   
        Model = '21sierra',
        Coords = vector4(-332.02, -133.95, 46.5, 158.79),
        Invincible = true,
        Frozen = true,
    }, 
}

------------------------------------------ SCRIPT ----------------------------------------
CreateThread(function()
    for i = 1, #CARConfig do
        local car = CARConfig[i]
        local model = GetHashKey(car.Model)
        local veh = CreateVehicle(model, car.Coords.x,car.Coords.y,car.Coords.z-1, false, false)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleDoorsLocked(veh, 3)
        SetEntityHeading(veh, car.Coords.w)
        Wait(1000)
        FreezeEntityPosition(veh, car.Frozen)
    end
end)

QBCore.Functions.CreateCallback('angelicxs-randomshop:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    return cb(inventory)
end)

RegisterNetEvent('angelicxs-randomshop:sellItems', function(itemName, itemAmount, itemPrice, Location)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local dist = #(playerCoords - vector3(Location.coords.x, Location.coords.y, Location.coords.z))
    if dist > 5 then print("Possible Exploit Attempt Player # "..src) return end
    if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
        if Location.markedbills then
            Player.Functions.AddItem('markedbills', totalPrice)
        else
            Player.Functions.AddMoney('cash', totalPrice)
        end
        TriggerClientEvent('QBCore:Notify', src, "You have sold "..tostring(itemAmount).." "..QBCore.Shared.Items[itemName].label.." for $ "..tostring(totalPrice),'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough items!", 'error')
    end
    TriggerClientEvent('angelicxs-randomshop:openMenu', src)
end)




QBCore.Functions.CreateCallback('angelicxs-buybackProgram:serverAction', function(source, cb, price, plate)
    local player = QBCore.Functions.GetPlayer(source)
    local allowed = false
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = @plate', {
        ['@plate']   = plate,
        }, function(result)           
        for i = 1, #result, 1 do
            if player.PlayerData.citizenid == result[i].citizenid then
                MySQL.Async.execute('DELETE FROM player_vehicles WHERE plate = @plate',{
                    ['@plate'] = plate,
                    }, function (rowsChanged)
                        allowed = true
                end)
            end                
        end
    end)
    Wait(2000)
    if allowed then
        player.Functions.AddMoney('cash', price)
        cb(true)
    else
        cb(false)
    end
end)

