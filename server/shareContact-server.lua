RegisterNetEvent('angelicxs:server:shareContactInformation', function(target, number, name)
    TriggerClientEvent('angelicxs:client:confirmContactInformation', target, number, name)
end)