QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("TestFuc", function(source, args, rawCommand)
    local basePrice = 0
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))))
    if QBCore.Shared.Vehicles[model] then
        basePrice = QBCore.Shared.Vehicles[model]["price"]
    else
        for k,v in pairs (QBCore.Shared.Vehicles) do
            if string.lower(v.name) == model then
                basePrice = v.price
                break
            end
        end
    end
    print(basePrice)
    -- If it's not a player, then it must be RCON, a resource, or the server console directly.

end, false)