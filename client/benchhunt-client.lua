local Custom = {}
local blip = false
QBCore = exports['qb-core']:GetCoreObject()

Custom.Marcus = {
    Spot = vector4(0,0,0,0),
    Model = "a_m_m_og_boss_01",
    Notify = "You gave Marcus your number",
    ThirdEye = "Give Marcus Your Contact Info",
    TextMessage = "Marcus: Word on the street there's a guy down in the southside handing out some important equipment, find him and see what's up.",
}

Custom.Sebastian = {
    Spot = vector4(0,0,0,0),
    Model = "cs_lamardavis",
    Notify = "Got equipment from sebastion",
    ThirdEye = "Whats good homie, you lookin for somethin",
    Item = "usb_32gb",
    TextMessage = "Sebastian: A friend of mine gave me this, His name isnt important. We will call him Mr. F, anyways he got locked up on the east coast and never told me what it was for. Find where this goes im sure its important.",
}

Custom.ItemPC = {
    Spot = vector3(0,0,0),
    Item = Custom.Sebastian.Item,
    ThirdEye = "PC",
    RemoveItem = true,
    ItemGive = "files",
    SendLocation = vector4(2430.58, 3159.95, 48.39, 233.5),
    Blip = 306,
    Colour = 1,
    BlipName = "CONTACT",
    Notify = "GO TO THE CONTACT LOCATION NOTED ON YOUR MAP",
}

Custom.John = {
    Spot = Custom.ItemPC.SendLocation,
    ItemTake = Custom.ItemPC.ItemGive,
    Model = "a_m_m_hillbilly_01",
    Notify = "Find where the radio goes",
    ThirdEye = "You got the files?",
    TextMessage = "John: Hey buddy, sorry I can't pay you but this might be better, that radio encoder is the last valuable thing I have, I'm sure you can find a way to make some money off it.",
    Item = "kq_radio_encoder",
}

Custom.InteractionList = {

}

Custom.GuardInfo = {
    -- BankCenter = vector3(-1136.62, -3397.37, 13.95),
    -- Active = false,
    -- Models = {
    --     "mp_m_securoguard_01",
    -- },
    -- Weapons = {
    --     "weapon_pistol",
    -- },
    -- Locations = {
    --     vector4(-1136.62, -3397.37, 13.95, 296.21),
    --     vector4(-1136.62, -3397.37, 13.95, 296.21),
    --     vector4(-1136.62, -3397.37, 13.95, 296.21),
    -- },
    -- Item = "sandwich",
    -- Retreived = false,
    -- ThirdEye = "Search Pockets",
}

CreateThread(function()
    while true do
        local playerData = QBCore.Functions.GetPlayerData()
        if playerData.citizenid ~= nil then
            break
        end
        Wait(500)
    end
    TriggerServerEvent('angelicxs-turnmeofflater')
    TriggerEvent('angelicxs-benchHunt:Client:InteractionListUpdate')
end)

RegisterNetEvent("angelicxs-benchHunt:Client:InteractionListUpdate", function()
    QBCore.Functions.TriggerCallback('angelicxs-benchHunt:InteractionUpdate', function(cb)
        for k,v in pairs(cb) do
            -- Custom.InteractionList = v
            for z,y in pairs (v) do
                if z == 'marcus' or z == 'sebastian' or z == 'john' or z == 'complete' then 
                    if tonumber(y) > 0 then
                        Custom.InteractionList[z] = true
                    else
                        Custom.InteractionList[z] = false
                    end
                end
            end
        end
    end)
end)

CreateThread(function()
    local marcus = false
    while true do
        Wait(2000)
        local pos = #(GetEntityCoords(PlayerPedId())-vector3(Custom.Marcus.Spot.x, Custom.Marcus.Spot.y, Custom.Marcus.Spot.z))
        if pos <= 50 and not DoesEntityExist(marcus) then
            local hash = HashGrabber(Custom.Marcus.Model)
            marcus = CreatePed(3, hash, Custom.Marcus.Spot.x, Custom.Marcus.Spot.y, (Custom.Marcus.Spot.z-1), Custom.Marcus.Spot.w, false, false)
            exports.ox_target:addLocalEntity(marcus, {
                {
                canInteract = function()
                    return not Custom.InteractionList.marcus and not Custom.InteractionList.complete
                end,
                onSelect = function()
                    QBCore.Functions.Notify(Custom.Marcus.Notify, 'primary')
                    TriggerServerEvent('angelicxs-sendMessage:qs-phone', Custom.Marcus.TextMessage)
                    TriggerServerEvent("angelicxs-benchHunt:Server:InteractionListUpdate", "marcus", 1)
                end,
                label = Custom.Marcus.ThirdEye,
                },
            })  
            SetBlockingOfNonTemporaryEvents(marcus, true)
            SetModelAsNoLongerNeeded(Custom.Marcus.Model)
        elseif pos > 50 and DoesEntityExist(marcus) then
            DeleteEntity(marcus)
        end
    end
end)

CreateThread(function()
    local sebastian = false
    while true do
        Wait(2000)
        local pos = #(GetEntityCoords(PlayerPedId())-vector3(Custom.Sebastian.Spot.x, Custom.Sebastian.Spot.y, Custom.Sebastian.Spot.z))
        if pos <= 50 and not DoesEntityExist(sebastian) then
            local hash = HashGrabber(Custom.Sebastian.Model)
            sebastian = CreatePed(3, hash, Custom.Sebastian.Spot.x, Custom.Sebastian.Spot.y, (Custom.Sebastian.Spot.z-1), Custom.Sebastian.Spot.w, false, false)
            exports.ox_target:addLocalEntity(sebastian, {
                {
                    canInteract = function()
                        return Custom.InteractionList.marcus and not Custom.InteractionList.sebastian and not Custom.InteractionList.complete
                    end,
                    onSelect = function()
                        QBCore.Functions.Notify(Custom.Sebastian.Notify, 'primary')
                        TriggerServerEvent('angelicxs-sendMessage:qs-phone', Custom.Sebastian.TextMessage)
                        TriggerServerEvent('angelicxs-giveItem:benchHunt', Custom.Sebastian.Item)
                        TriggerServerEvent("angelicxs-benchHunt:Server:InteractionListUpdate", "sebastian", 1)
                    end,
                    label = Custom.Sebastian.ThirdEye,
                },
            })  
            SetBlockingOfNonTemporaryEvents(sebastian, true)
            SetModelAsNoLongerNeeded(Custom.Sebastian.Model)
        elseif pos > 50 and DoesEntityExist(sebastian) then
            DeleteEntity(sebastian)
        end
    end
end)

CreateThread(function()
    exports.ox_target:addBoxZone(
    {
        coords = Custom.ItemPC.Spot,
        size = vec3(2.5,2.5,1.5),
        options = {
            {
            label = Custom.ItemPC.ThirdEye,
            canInteract = function()
                local hasItem = QBCore.Functions.HasItem(Custom.ItemPC.Item) 
                return hasItem and not Custom.InteractionList.complete
            end,
            onSelect = function()
                if Custom.ItemPC.RemoveItem then
                    TriggerServerEvent('angelicxs-removeItem:benchHunt', Custom.ItemPC.Item)
                end
                TriggerServerEvent('angelicxs-giveItem:benchHunt', Custom.ItemPC.ItemGive)
                TriggerServerEvent('angelicxs-sendMessage:qs-phone', Custom.ItemPC.Notify)
                blip = AddBlipForCoord(Custom.ItemPC.SendLocation.x,Custom.ItemPC.SendLocation.y,Custom.ItemPC.SendLocation.z)
                SetBlipSprite(blip, Custom.ItemPC.Blip)
                SetBlipColour(blip, Custom.ItemPC.Colour)
                SetBlipScale(blip, 0.7)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(Custom.ItemPC.BlipName)
                EndTextCommandSetBlipName(blip)
            end,
            },
        },
    })
end)


CreateThread(function()
    local john = false
    while true do
        Wait(2000)
        local pos = #(GetEntityCoords(PlayerPedId())-vector3(Custom.John.Spot.x, Custom.John.Spot.y, Custom.John.Spot.z))
        if pos <= 50 and not DoesEntityExist(john) then
            if DoesBlipExist(blip) then RemoveBlip(blip) blip = false end
            local hash = HashGrabber(Custom.John.Model)
            john = CreatePed(3, hash, Custom.John.Spot.x, Custom.John.Spot.y, (Custom.John.Spot.z-1), Custom.John.Spot.w, false, false)
            exports.ox_target:addLocalEntity(john, {
                {
                    canInteract = function()
                        local hasItem = QBCore.Functions.HasItem(Custom.John.ItemTake)
                        return hasItem and Custom.InteractionList.sebastian and not Custom.InteractionList.john and not Custom.InteractionList.complete
                    end,
                    onSelect = function()
                        TriggerServerEvent('angelicxs-removeItem:benchHunt', Custom.John.ItemTake)
                        QBCore.Functions.Notify(Custom.John.Notify, 'primary')
                        TriggerServerEvent('angelicxs-sendMessage:qs-phone', Custom.John.TextMessage)
                        TriggerServerEvent('angelicxs-giveItem:benchHunt', Custom.John.Item)
                        TriggerServerEvent("angelicxs-benchHunt:Server:InteractionListUpdate", "john", 1)
                        -- GuardSpawner()
                    end,
                    label = Custom.John.ThirdEye,
                },
            })  
            SetBlockingOfNonTemporaryEvents(john, true)
            SetModelAsNoLongerNeeded(Custom.John.Model)
        elseif pos > 50 and DoesEntityExist(john) then
            DeleteEntity(john)
        end
    end
end)


-------------------------- FLEECA BANK ROBBERY

-- Activate angelicxs-benchHunt:Client:InteractionListUpdate before they start to check Custom.InteractionList.complete



--[[ the player goes and robs the fleeca bank. inside the vault theres 2 guards that start shooting (if this is possible) and the players have to kill the guard. 

once they kill the guards they can third eye them and they get a "key" (one singular key)

once 1 person in the entire server completes this full proccess the key can no longer be obtained by anyone else 

this key will open the door to the black market ]]
--------------------------- FLEECA BANK ROBBERY

CreateThread(function()
    --Close Bank Door
end)

RegisterNetEvent("angelicxs-benchHunt:StartBank", function()
    Custom.GuardInfo.Active = true
    LootAnim(obj)--PUT BANK VAULT HERE
    --Open Bank Door
end)

function GuardSpawner()
    TriggerEvent('angelicxs-benchHunt:Client:InteractionListUpdate')
    local Guard = {}
    while true do
        local dist = #(GetEntityCoords(PlayerPedId())-Custom.GuardInfo.BankCenter)
        if dist <= 100 then
            break
        end
        Wait(100)
    end
    if Custom.InteractionList.complete then return end
    for i = 1, #Custom.GuardInfo.Locations do
        local spot = Custom.GuardInfo.Locations[i]
        local model = Randomizer(Custom.GuardInfo.Models)
        local weapon = Randomizer(Custom.GuardInfo.Weapons)
        local hash = HashGrabber(Randomizer(model))
        Guard[i] = CreatePed(4, hash, spot.x, spot.y, spot.z-1, spot.w, true, true)
        while not DoesEntityExist(Guard[i]) do Wait(50) end
        SetEntityAsMissionEntity(Guard[i], true, true)
        NetworkRegisterEntityAsNetworked(Guard[i])
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(Guard[i]), true)
        SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(Guard[i]), true)
        SetPedArmour(Guard[i], 100)
        GiveWeaponToPed(Guard[i], weapon, 500)
        SetPedFleeAttributes(Guard[i], 0, false)
        SetPedCombatAttributes(Guard[i], 0, true)
        SetPedCombatAttributes(Guard[i], 1, true)
        SetPedCombatAttributes(Guard[i], 2, true)
        SetPedCombatAttributes(Guard[i], 3, true)
        SetPedCombatAttributes(Guard[i], 46, true)
        SetPedCombatAbility(Guard[i], 2)
        SetPedCombatMovement(Guard[i], 1)
        SetPedAsCop(Guard[i], true)
        SetPedAccuracy(Guard[i], 100)
        SetPedCombatRange(Guard[i], 2)
        SetEntityVisible(Guard[i], true)
        SetPedKeepTask(Guard[i], true)    
        SetModelAsNoLongerNeeded(model)
        CreateThread(function()
            while true do
                Wait(1000)
                if Custom.GuardInfo.Active then
                    TaskCombatPed(Guard[i], PlayerPedId(), 0, 16)
                    break
                end
            end
        end)
        exports.ox_target:addLocalEntity(Guard[i], {
            {
                canInteract = function()
                    return IsPedDeadOrDying(Guard[i]) and not Custom.GuardInfo.Retreived
                end,
                onSelect = function()
                    TriggerServerEvent("angelicxs-benchHunt:Server:InteractionListUpdate", "complete", 1)
                    Custom.GuardInfo.Retreived = true
                    LootAnim(Guard[i])
                    TriggerServerEvent("angelicxs-benchHunt:Server:CompletetInteractionListUpdate")
                    TriggerServerEvent('angelicxs-giveItem:benchHunt', Custom.GuardInfo.Item)
                end,
                label = Custom.GuardInfo.ThirdEye,
            },
        })  
        Wait(100)
    end
end

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

function Randomizer(Options)
    local List = Options
    local Number = 0
    math.random()
    local Selection = math.random(1, #List)
    for i = 1, #List do
        Number = Number + 1
        if Number == Selection then
            return List[i]
        end
    end
end

function LootAnim(obj)
    local Player = PlayerPedId()
    if obj then
        TaskTurnPedToFaceEntity(Player, obj, -1)
    end
    FreezeEntityPosition(Player, true)
    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
        Wait(10)
    end
    TaskPlayAnim(Player,"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer",1.0, -1.0, -1, 49, 0, 0, 0, 0)
    Wait(5500)	
    ClearPedTasks(Player)
    FreezeEntityPosition(Player, false)
    RemoveAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
end