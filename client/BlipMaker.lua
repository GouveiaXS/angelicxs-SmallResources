-- Blip info: https://docs.fivem.net/docs/game-references/blips/


local blips = {
    {name = "GFC Gunshop", coords = vector3(112.01, 188.32, 104.82), colour = 1, sprite = 110},
    {name = "Dead Man Running Gunshop", coords = vector3(1154.78, -468.29, 66.56), colour = 1, sprite = 110},
    {name = "Hunting Shop", coords = vector3(-679.94, 5835.33, 17.33), colour = 8, sprite = 432},
    {name = "Self Storage", coords = vector3(-1698.37, -754.46, 13.79), colour = 38, sprite = 120},
    {name = "Eves Underground", coords = vector3(841.67, -191.05, 72.67), colour = 27, sprite = 147},
}

for k,v in pairs(blips) do
    CreateThread(function()
        local blipIcon = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(blipIcon, v.sprite)
        SetBlipScale(blipIcon, 0.7)
        SetBlipAsShortRange(blipIcon, true)
        SetBlipColour(blipIcon, v.colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.name)
        EndTextCommandSetBlipName(blipIcon)
    end)
end