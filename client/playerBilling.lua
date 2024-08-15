RegisterNetEvent('angelicxs-phonebridge:client:sendbill', function()
    local menu = {}
    local input = lib.inputDialog("Send Invoice", {
        {type = 'number', label = 'ID', required = true},
        {type = 'number', label = 'Amount', required = true},
        {type = 'select', label = 'Invoice Type', options = {{label = "Personal", value = "personal"}, {label = "Job", value = "job"}}, required = true},
    }) 
    if not input then return end
    TriggerServerEvent('angelicxs-phonebridge:server:sendbill', input[1], input[2], input[3], input[4])
end)