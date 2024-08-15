--[[
CREATE TABLE IF NOT EXISTS `angelicxs_benchHunt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) DEFAULT NULL,
  `marcus` smallint(6) NOT NULL DEFAULT 0,
  `sebastian` smallint(6) NOT NULL DEFAULT 0,
  `john` smallint(6) NOT NULL DEFAULT 0,
  `complete` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
]]


QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('angelicxs-sendMessage:qs-phone', function(message)
    local src = source
    local identifier = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    invoiceMailData = {
        sender = 'Unknown Email',
        subject = 'Unknown Request',
        message = message
    }
    exports['lb-phone']:sendNewMailToOffline(identifier, invoiceMailData)
end)

RegisterNetEvent('angelicxs-giveItem:benchHunt', function(item, amount)
    local Number = 1
    if amount then Number = amount end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, Number)
end)

RegisterNetEvent('angelicxs-removeItem:benchHunt', function(item, amount)
    local Number = 1
    if amount then Number = amount end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, Number)
end)

RegisterNetEvent("angelicxs-benchHunt:Server:InteractionListUpdate", function(interact, value)
    local player = QBCore.Functions.GetPlayer(source)
    local cid = player.PlayerData.citizenid
    MySQL.Async.execute('UPDATE angelicxs_benchHunt SET '..tostring(interact)..' = @value WHERE identifier = @identifier', {
        ['@identifier'] = cid,
        ['@value'] = value,
        }, function (rowsChanged)
    end)
    TriggerClientEvent("angelicxs-benchHunt:Client:InteractionListUpdate", source)
end)

RegisterNetEvent("angelicxs-benchHunt:Server:CompletetInteractionListUpdate", function()
    MySQL.Async.execute('UPDATE angelicxs_benchHunt SET complete = 1 WHERE complete = 0', {
        }, function (rowsChanged)
    end)
    TriggerEvent('qb-log:server:CreateLog', 'https://discord.com/api/webhooks/1217162631312441485/KWIhRhLN8Dph1vGRGmMoOTG93pSXBPouGSBihV50W6iXKLIufH0XAPBOZqJeIxLUwiAt', 'Bench Hunt', 'green', 'A player has completed the bench hun!\n**Person**:\n'..GetPlayerName(src))
    TriggerClientEvent("angelicxs-benchHunt:Client:InteractionListUpdate", -1)
end)

QBCore.Functions.CreateCallback('angelicxs-benchHunt:InteractionUpdate', function(source, cb)
    local player = QBCore.Functions.GetPlayer(source)
    local cid = player.PlayerData.citizenid
    MySQL.Async.fetchAll('SELECT * FROM angelicxs_benchHunt WHERE identifier = @identifier', {
        ['@identifier'] = cid,
        }, function (result)
        cb(result)
    end)
end)

RegisterNetEvent('angelicxs-turnmeofflater', function()
    local player = QBCore.Functions.GetPlayer(source)
    local cid = player.PlayerData.citizenid
    MySQL.Async.fetchAll('SELECT * FROM angelicxs_benchhunt WHERE identifier = @identifier', {
        ["@identifier"] = cid
    }, function (result)
        local ifOwner = table.unpack(result)
        if ifOwner ~= nil then
        else
            MySQL.Async.execute('INSERT INTO angelicxs_benchhunt (identifier) VALUES (@identifier)',
            {
                ['@identifier'] = cid,
             }, function (rowsChanged)
             end)
        end
    end)
end)
