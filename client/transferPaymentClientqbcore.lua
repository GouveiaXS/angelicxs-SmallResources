local JobInfo = { -- Name of job = Min rank to transfer funds
    sasp = 1,   
    ambulance = 1,

}

QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = nil
local PlayerGrade = nil

CreateThread(function ()
    while true do
        PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData.citizenid ~= nil then
            PlayerJob = PlayerData.job.name
            PlayerGrade = PlayerData.job.grade.level
            break
        end
        Wait(100)
    end
    TriggerServerEvent('angelicxs-playertransfer:paymentReceipt')
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerJob = PlayerData.job.name
    PlayerGrade = PlayerData.job.grade.level
    Wait(100)
    TriggerServerEvent('angelicxs-playertransfer:paymentReceipt')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job.name
    PlayerGrade = job.grade.level
end)
RegisterNetEvent('angelicxs-playertransfer:messages', function(message, type)
    QBCore.Functions.Notify(message, type)
end)

function Checker()
    for k,v in pairs(JobInfo) do
        if tostring(k) == PlayerJob and PlayerGrade >= v then return true end
    end
    return false
end

RegisterNetEvent('angelicxs-playertransfer:checker', function()
    if not Checker() then QBCore.Functions.Notify("You are not eligable to use this feature.", "error") return end
    local menu = {}
    local input = lib.inputDialog("Transfer Funds to Cousin", {"Fund Amount", "Citizen ID"})
    if not input then return end
    if tonumber(input[1]) <= 0 then QBCore.Functions.Notify("You must enter an amount greater than 0.", "error") return end
    table.insert(menu, {
        title = "Confirm",
        onSelect = function()
            TriggerServerEvent('angelicxs-playertransfer:paymentSubmission', tonumber(input[1]), string.upper(tostring(input[2])))
        end,
    })
    table.insert(menu, {
        title = "Cancel",
        onSelect = function()
        end,
    })
    lib.registerContext({
        id = 'playertransfer_ox',
        options = menu,
        title = "Are you sure you want to transfer $"..tostring(input[1]).." to citizen "..string.upper(tostring(input[2])).."?",
        position = 'top-right',
    }, function(selected, scrollIndex, args)
    end)
    lib.showContext('playertransfer_ox')
end)