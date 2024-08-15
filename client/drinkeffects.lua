local drinkConfig = {
    TimeReducer = 120, -- how long in seconds before drink level goes down by 1
    level1 = 2,
    level2 = 4,
    level3 = 6,
    level4 = 8,
}
local drinkList = {}

local currentDrink = 0
local effectActive = {blur = false, dizzy = false, stumble = false, vomit = false}

RegisterNetEvent('angelicxs-smallresources:client:DrinkAlcohol', function()
    currentDrink = currentDrink+1
end)

RegisterNetEvent('angelicxs-customeffects', function(itemName)
    local ped = PlayerPedId()
    if itemName == 'longislandicedtea' then
        ResetPlayerStamina(PlayerId())
    end
end)


CreateThread(function()
    while true do
        Wait(1000)
        if currentDrink >= drinkConfig.level1 then
            if not effectActive.blur then CreateThread(function() BlurryVision() end) end
            if currentDrink >= drinkConfig.level2 then
                if not effectActive.dizzy then CreateThread(function() Dizzy() end) end
                if currentDrink >= drinkConfig.level3 then
                    if not effectActive.stumble then CreateThread(function() Stumbling() end) end
                    if currentDrink >= drinkConfig.level4 then
                        if not effectActive.vomit then CreateThread(function() Vomiting() end) end
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000*drinkConfig.TimeReducer)
        if currentDrink > 0 then
            currentDrink = currentDrink-1
        end
    end
end)

function BlurryVision()--------------------------------------
    effectActive.blur = true
    AnimpostfxPlay('MP_Celeb_Lose', 15000, true)
    while currentDrink >= drinkConfig.level1 do
        SetCamEffect(1)
        Wait(0)
    end
    AnimpostfxStop('MP_Celeb_Lose')
    AnimpostfxStop('MP_Celeb_Lose')
    SetCamEffect(0)
    effectActive.blur = false
end

function Dizzy()
    effectActive.dizzy = true
    SetPedMovementClipset(ped, 'MOVE_M@DRUNK@MODERATEDRUNK', 0.5)
    while currentDrink >= drinkConfig.level2 do
        Wait(1000)
    end
    ResetPedMovementClipset(ped, 2)
    ClearPedTasks(ped)
    effectActive.dizzy = false
end

function Stumbling()
    effectActive.stumble = true
    while currentDrink >= drinkConfig.level3 do
        local sleep = math.random(20, 30)
        SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
        Wait(sleep*1000)
    end
    effectActive.stumble = false
end

function Vomiting()
    effectActive.vomit = true
    while currentDrink >= drinkConfig.level4 do
        local sleep = math.random(30, 90)
        local ped = PlayerPedId()
        local dict = 'oddjobs@taxi@tie'
        local anim = 'vomit_outside'
        AnimDictLoader(dict)
        AnimpostfxPlay('SwitchHUDIn', 3000, false)
        TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)
        Wait(8000)
        AnimpostfxStop('SwitchHUDIn')
        RemoveAnimDict(dict)
        ClearPedTasks(ped)
        Wait(sleep*1000)
    end
    AnimpostfxStop('SwitchHUDIn')
    AnimpostfxStop('SwitchHUDOut')
    ClearPedTasks(ped)
    effectActive.vomit = false
end


function AnimDictLoader(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
end

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        currentDrink = 0
        effectActive = {blur = false, dizzy = false, stumble = false, vomit = false}
        local ped = PlayerPedId()
        SetCamEffect(0)
        ResetPedMovementClipset(ped, 2)
        AnimpostfxStop('MP_Celeb_Lose')
        AnimpostfxStop('SwitchHUDIn')
        AnimpostfxStop('SwitchHUDOut')
        ClearPedTasks(ped)
    end
end)