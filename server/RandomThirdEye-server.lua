local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('Angelicxs-GainRacingLaptopItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('racingtablet', 1)
    TriggerClientEvent('angelicxs-playertransfer:messages', src, "You found something useful!", 'success')
end)

RegisterNetEvent('Angelicxs-GainBoostingLaptopItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('boostingtablet', 1)
    TriggerClientEvent('angelicxs-playertransfer:messages', src, "You found something useful!", 'success')
end)