-- -- -- Model List = https://gta-objects.xyz/objects

ObjConfig = {
    {   
        Model = 'gr_prop_gr_bench_04b',
        Coords = vector4(-474.3, 6192.10009765625, 33.19, -88),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'xm_prop_base_staff_desk_01',
        Coords = vector4(7.40000009536743, 530.7000122070312, 170.60000610351565, 384.8999938964844),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_box_wood05a',
        Coords = vector4(-1150.17, 4940.51, 222.27, 65.75),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'v_ret_gc_chair03',
        Coords = vector4(-946.2, -2066.51, 9.61, 279.57),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_laptop_jimmy',
        Coords = vector4(-947.23, -2066.7, 10.61, 135.03),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_laptop_jimmy',
        Coords = vector4(647.27, 909.22, 253.58, 175.15),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_roadpole_01b',
        Coords = vector4(341.75, -1399.59, 32.51, 59.14),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_roadpole_01b',
        Coords = vector4(344.08, -1396.53, 32.51, 48.81),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_roadpole_01b',
        Coords = vector4(307.38, -1433.62, 29.93, 137.67),
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_pooltable_02', --pooltable
        Coords = vector4(-1518.14, 123.64, 60.8, 133.6),  --random test
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_pool_rack_01', --cues
        Coords = vector4(-1526.84, 122.29, 60.79, 270.63),  --random test
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_pool_rack_01', --cues
        Coords = vector4(341.49, -1370.7, 38.38, 47.66),  --random test
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_metal_plates01', --parachute point
        Coords = vector4(-153.39, -882.15, 2547.34, 303.29),  
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_metal_plates01', --parachute point
        Coords = vector4(-150.39, -880.15, 2547.34, 303.29),  
        Invincible = true,
        Frozen = true,
    },
    {   
        Model = 'prop_metal_plates01', --parachute point
        Coords = vector4(-150.39, -882.15, 2547.34, 303.29),  
        Invincible = true,
        Frozen = true,
    },

}



------------------------------------------ SCRIPT ----------------------------------------
local Entity = {}
CreateThread(function()
    for i = 1, #ObjConfig do
        CreateThread(function()
            local obj = ObjConfig[i]
            local ObjSpawned = false
            Entity[i] = nil
            while true do
                local Player = PlayerPedId()
                local Pos = GetEntityCoords(Player)
                local Dist = #(Pos - vector3(obj.Coords.x,obj.Coords.y,obj.Coords.z))
                if Dist <= 50 and not ObjSpawned then
                    TriggerEvent('angelicxs-obkSpawner:ObjSpawner',obj,i)
                    ObjSpawned = true
                elseif DoesEntityExist(Entity[i]) and ObjSpawned then
                    local Dist2 = #(Pos - GetEntityCoords(Entity[i]))
                    if Dist2 > 50 then
                        SetEntityAsNoLongerNeeded(Entity[i])
                        ObjSpawned = false
                    end
                end
                Wait(2000)
            end
        end)
    end
end)

RegisterNetEvent('angelicxs-obkSpawner:ObjSpawner',function(obj,set)
    local hash = HashGrabber(obj.Model)
    Entity[set] = CreateObject(hash, obj.Coords.x, obj.Coords.y, (obj.Coords.z-1), false, false, false)
    SetEntityHeading(Entity[set], obj.Coords.w)
    FreezeEntityPosition(Entity[set], obj.Frozen)
    SetEntityInvincible(Entity[set], obj.Invincible)
    SetModelAsNoLongerNeeded(obj.Model)
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

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        for i=1, #Entity do
            if DoesEntityExist(Entity[i]) then
                DeleteEntity(Entity[i])
            end
        end
    end
end)

-- rtx gym stats on radial menu


RegisterNetEvent('angelicxs-gymstatsturnon', function()
    TriggerEvent("rtx_gym:ShowStats", true)
end)