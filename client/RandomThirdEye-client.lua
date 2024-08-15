exports.ox_target:addBoxZone({
    coords = vector3(-1532.82, -401.04, 35.63),
    size = vec3(1, 1.1, 1),
    rotation = 229.19,
    debug = drawZones,
    options = {
        {
            name = 'GetRacingTablet',
            icon = 'fas fa-hand',
            label = "Search Shelf",
            onSelect = function()
                TriggerServerEvent('Angelicxs-GainRacingLaptopItem')
            end,
            canInteract = function()
                return not QBCore.Functions.HasItem('racingtablet')
            end,
        }
    }
})

exports.ox_target:addBoxZone({
    coords = vector3(1271.5, -1712.02, 54.84),
    size = vec3(1, 1.1, 1),
    rotation = 106.48,
    debug = drawZones,
    options = {
        {
            name = 'GetBoostingTablet',
            icon = 'fas fa-hand',
            label = "Search Shelf",
            onSelect = function()
                TriggerServerEvent('Angelicxs-GainBoostingLaptopItem')
            end,
            canInteract = function()
                return not QBCore.Functions.HasItem('boostingtablet')
            end,
        }
    }
})