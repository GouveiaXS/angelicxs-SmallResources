QBCore = exports['qb-core']:GetCoreObject()

local vehicle = nil
CreateThread(function()
    while true do
        Wait(0)
        SetPedSuffersCriticalHits(PlayerPedId(), false) ---stop  headshot one shot
        if vehicle ~= 0 then
            local roll = GetEntityRoll(vehicle)
            if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
                DisableControlAction(2, 59, true) -- Disable left/right
                DisableControlAction(2, 60, true) -- Disable up/down
            end
        end
    end
end)

CreateThread(function()
    while true do
        vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        Wait(1000)
    end
end)

-- Police Boat Spawn
RegisterNetEvent('angelicxs:emergancyboat', function()
    local player = QBCore.Functions.GetPlayerData()
    local job = player.job.name
    if job == 'sasp' or job == 'saspoff' then
        if IsEntityInWater(PlayerPedId()) then
            local hash = HashGrabber('predator')
            local coords = GetEntityCoords(PlayerPedId())
            while not hash do Wait(100) end
            local boat = CreateVehicle(hash, coords.x, coords.y, coords.z, coords.w, true, true)
            local plate = 'SASPB'..math.random(000,999)
            while not boat do Wait(100) end
            SetVehicleNumberPlateText(boat, plate)
            exports['cdn-fuel']:SetFuel(boat, 100)
            TriggerEvent('vehiclekeys:client:SetOwner', plate)
            TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
            SetVehicleEngineOn(boat, true, true, false)
        else
            QBCore.Functions.Notify("Not in enough water!", 'error')
        end
    elseif job == 'ambulance' then
        if IsEntityInWater(PlayerPedId()) then
            local hash = HashGrabber('dinghy3')
            local coords = GetEntityCoords(PlayerPedId())
            while not hash do Wait(100) end
            local boat = CreateVehicle(hash, coords.x, coords.y, coords.z, coords.w, true, true)
            local plate = 'EMSB'..math.random(0000,9999)
            while not boat do Wait(100) end
            SetVehicleNumberPlateText(boat, plate)
            exports['cdn-fuel']:SetFuel(boat, 100)
            TriggerEvent('vehiclekeys:client:SetOwner', plate)
            TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
            SetVehicleEngineOn(boat, true, true, false)
        else
            QBCore.Functions.Notify("Not in enough water!", 'error')
        end
    else
        QBCore.Functions.Notify("ALERT ALERT ALERT", 'error')
    end
end)

function HashGrabber(model)
    local hash = GetHashKey(model)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
      Wait(10)
    end
    return hash
end