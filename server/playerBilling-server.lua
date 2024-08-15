RegisterNetEvent('angelicxs-phonebridge:server:sendbill', function(input1, input2, input3)
    local src = source
    local target = tonumber(input1)
    local price = tonumber(input2)
    local type = tostring(input3)
    local biller = QBCore.Functions.GetPlayer(src)
    local billed = QBCore.Functions.GetPlayer(target)
    reason = reason == '' and "No Invoice Details Provided" or reason
    if not target or not price then
        return TriggerClientEvent('angelicxs-playertransfer:messages', src, "The individual is not in the city at this time.", 'error')
    end
    MySQL.Sync.execute('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid, type) VALUES (?, ?, ?, ?, ?, ?)',
        { billed.PlayerData.citizenid,
        price,
        biller.PlayerData.job.name,
        biller.PlayerData.charinfo.firstname,
        biller.PlayerData.citizenid,
        type
    })
    TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
    TriggerClientEvent('angelicxs-playertransfer:messages', src, "You have sent an invoice to " .. billed.PlayerData.charinfo.firstname..' '..billed.PlayerData.charinfo.lastname, 'success')    
    TriggerClientEvent('angelicxs-playertransfer:messages', billed.PlayerData.source, "You have received an invoice in the amount of $"..tostring(price)..' from '..biller.PlayerData.charinfo.firstname..' '..biller.PlayerData.charinfo.lastname, 'primary')
end)