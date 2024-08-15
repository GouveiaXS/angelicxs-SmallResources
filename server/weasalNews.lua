local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('RevivalNews', "Time (seconds) / Description", {{name = 'Time', help = 'Time in seconds'}, {name = 'Description', help = 'Details of news event'}}, flase, function(source, args)
    local time = tonumber(args[1])
    table.remove(args, 1)
    local info = table.concat(args, " ")
    TriggerClientEvent('angelicxs-weasalNews:timerUpdate', -1, time)
    TriggerClientEvent('angelixs-weasalNews:notify', -1, "Revival News Exclusive", info)
end, admin)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    local time = 10
    TriggerClientEvent('angelicxs-weasalNews:timerUpdate', -1, time)
    if eventData.secondsRemaining == 1800 then
        TriggerClientEvent('angelixs-weasalNews:notify', -1, "Revival News Exclusive", "Tsunami expected to hit city within 30 minutes, begin to seek high ground!")
    elseif eventData.secondsRemaining == 900 then
        exports["qb-weathersync"]:setWeather("CLOUDS")
        TriggerClientEvent('angelixs-weasalNews:notify', -1, "Revival News Exclusive", "Tsunami expected to hit city within 15 minutes, seek shelter right away!")
    elseif eventData.secondsRemaining == 300 then
        exports["qb-weathersync"]:setWeather("RAIN")
        TriggerClientEvent('angelixs-weasalNews:notify', -1, "Revival News Exclusive", "Tsunami expected to hit city within five (5) minutes, take cover now!")
    elseif eventData.secondsRemaining == 60 then
        exports["qb-weathersync"]:setWeather("THUNDER")
        TriggerClientEvent('angelixs-weasalNews:notify', -1, "Revival News Exclusive", "Tsunami expected to hit city within 60 seconds! Get out now!")
    end
end)