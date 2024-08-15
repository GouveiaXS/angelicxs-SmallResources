QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('angelicxs:client:shareContactInformation', function()
    local closestPlayer, distance = QBCore.Functions.GetClosestPlayer()
    local playerData = QBCore.Functions.GetPlayerData()
    local phone = playerData.charinfo.phone
    local name = playerData.charinfo.firstname..' '..playerData.charinfo.lastname
    if distance <= 5 then
        TriggerServerEvent('angelicxs:server:shareContactInformation', GetPlayerServerId(closestPlayer), phone, name)
    end
end)


RegisterNetEvent('angelicxs:client:confirmContactInformation', function(number, name)
    if IsPedInAnyVehicle(PlayerPedId(), true) then QBCore.Functions.Notify(name.." tried to give you their contact information, please leave your vehicle and have them try again", 'primary') return end
    local contactMenu = {}
    table.insert(contactMenu, {
        title = "Yes",
        onSelect = function()
            TriggerServerEvent('qb-phone:server:AddNewContact', name, number, '')
        end,
    })
    lib.registerContext({
        id = 'contactMenu_ox',
        options = contactMenu,
        title = name..' has shared their phone number ('..number..') with you. Would you like to add it to your phone?',
        position = 'top-right',
    }, function(selected, scrollIndex, args)
    end)
    lib.showContext('contactMenu_ox')
end)