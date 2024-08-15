QBcore = nil

local paidped = {
    EOO67125 = 'DeadpoolMovie',
    GZV13145= 'DeadpoolMovie',
}

QBCore = exports['qb-core']:GetCoreObject()


RegisterCommand('applypaidped', function()
    local player = QBCore.Functions.GetPlayerData()
    for cid,ped in pairs (paidped) do
        if tostring(cid) == (player.citizenid) then
            local model = GetHashKey(ped)
            RequestModel(model)
            while not HasModelLoaded(model) do
                RequestModel(model)
                Wait(0)
            end
            SetPlayerModel(PlayerId(), model)
            SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
        end
    end
end)

