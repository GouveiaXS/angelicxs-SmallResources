
local tempStash = {
    --{poly = false, name = "Tropical Roof Tray 1", loc = vector3(313.63, -933.96, 58.46)},
    {poly = true, name = "Tropical Roof Tray 1", loc = {vector3(312.97, -934.65, 57.0), vector3(316.08, -934.49, 57.0), vector3(315.82, -933.29, 57.0), vector3(311.42, -933.29, 57.0)}},
    {poly = true, name = "Tropical Bar Tray 1", loc = {vector3(295.68, -912.19, 52.83), vector3(293.0, -911.96, 52.8), vector3(292.8, -914.07, 52.8), vector3(296.14, -914.0, 52.8)}},
    {poly = true, name = "Luck Plucker Tray 1", loc = {vector3(137.65, -1469.07, 29.38), vector3(138.29, -1468.33, 29.37), vector3(137.33, -1467.56, 29.37), vector3(136.69, -1468.43, 29.37)}},
    {poly = true, name = "Luck Plucker Tray 2", loc = {vector3(137.91, -1466.95, 29.37), vector3(138.59, -1466.24, 29.37), vector3(139.33, -1467.16, 29.37), vector3(138.78, -1467.79, 29.37)}},
    {poly = true, name = "Luck Plucker Tray 3", loc = {vector3(139.84, -1466.58, 29.37), vector3(140.31, -1465.84, 29.37), vector3(139.49, -1465.19, 29.37), vector3(138.97, -1465.75, 29.37)}},
    {poly = true, name = "Luck Plucker Drive Thru", loc = {vector3(143.68, -1464.06, 29.37), vector3(142.32, -1463.02, 29.36), vector3(142.56, -1462.09, 29.36), vector3(144.56, -1463.91, 29.36)}},

}

for k,v in pairs (tempStash) do
    if v.poly then
        exports.ox_target:addPolyZone({
            points = v.loc,
            thickness = 2,
            debug = drawZones,
            options = {
                {
                    name = v.loc,
                    icon = 'fas fa-hand',
                    label = v.name,
                    onSelect = function()
                        TriggerEvent('angelicxs-tempstash', v.name)
                    end,
                }
            }
        })
    else
        exports.ox_target:addBoxZone({
            coords = v.loc,
            size = vec3(1, 1, 2),
            rotation = 10.10,
            debug = drawZones,
            options = {
                {
                    name = v.loc,
                    icon = 'fas fa-hand',
                    label = v.name,
                    onSelect = function()
                        TriggerEvent('angelicxs-tempstash', v.name)
                    end,
                }
            }
        })
    end
end 

RegisterNetEvent('angelicxs-tempstash', function(name)
    TriggerServerEvent('inventory:server:OpenInventory', 'stash', name, {
        maxweight = 10000,
        slots = 5,
    })
    TriggerEvent('inventory:client:SetCurrentStash', name)
end)