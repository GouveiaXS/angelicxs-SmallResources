local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('angelicxs-playertransfer:paymentReceipt', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM angelicxs_playertransfer WHERE identifier = @identifier', {
        ['@identifier'] = string.upper(tostring(Player.PlayerData.citizenid)),
        }, function (result)
        if result[1] then
            for k, v in pairs(result) do
                if tostring(v.identifier) == tostring(Player.PlayerData.citizenid) and tonumber(v.amount) > 0 then
                    print("money recieved to:", Player.PlayerData.citizenid, tostring(v.amount))
                    Player.Functions.AddMoney('bank', v.amount)
                    TriggerClientEvent('angelicxs-playertransfer:messages', src, "Your bank account has received transfer funds in the amount of $"..tostring(v.amount), 'primary')
                end
            end
        end
        MySQL.Async.execute('DELETE FROM angelicxs_playertransfer WHERE identifier = @identifier',{
            ['@identifier'] = Player.PlayerData.citizenid,
            }, function (rowsChanged)
        end)
    end)
end)

RegisterNetEvent('angelicxs-playertransfer:paymentSubmission', function(amount, id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.PlayerData.money['bank']
    if cash >= amount then
        Player.Functions.RemoveMoney("bank", amount, "Bank-Transfer")
        MySQL.Async.execute('INSERT INTO angelicxs_playertransfer (identifier, amount) VALUES (@identifier, @amount)',
            {
                ['@identifier']   = id,
                ['@amount']   = amount,
            }, function (rowsChanged)
        end)
    else
        TriggerClientEvent('angelicxs-playertransfer:messages', src, "You do not have enough bank funds to complete this transaction.", 'error')
    end
end)