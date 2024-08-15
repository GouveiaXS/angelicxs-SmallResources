local NewsTimer = false

RegisterNetEvent('angelicxs-weasalNews:timerUpdate', function(timer)
    local set = timer
    NewsTimer = true
    while true do
        set = set-1
        if set <=0 then NewsTimer = false break end
        Wait(1000)
    end
end)

RegisterNetEvent('angelixs-weasalNews:notify', function(top, info)
    CreateThread(function()
        local scaleform2 = RequestScaleformMovie('breaking_news')
        while not HasScaleformMovieLoaded(scaleform2) do Wait(10) end
        PushScaleformMovieFunction(scaleform2, "breaking_news")
        PopScaleformMovieFunctionVoid()
        BeginScaleformMovieMethod(scaleform2, 'SET_TEXT')
        PushScaleformMovieMethodParameterString("Breaking News")
        PushScaleformMovieMethodParameterString(info)
        EndScaleformMovieMethod()
        BeginScaleformMovieMethod(scaleform2, "SET_SCROLL_TEXT")
        PushScaleformMovieMethodParameterInt(0)
        PushScaleformMovieMethodParameterInt(0)
        PushScaleformMovieMethodParameterString(top)
        EndScaleformMovieMethod()
        BeginScaleformMovieMethod(scaleform2, "DISPLAY_SCROLL_TEXT")
        PushScaleformMovieMethodParameterInt(0)
        PushScaleformMovieMethodParameterInt(0)
        EndScaleformMovieMethod()
        while NewsTimer do
            Wait(0)
            if not NewsTimer then break end
            DrawScaleformMovieFullscreen(scaleform2, 255, 255, 255, 255)
        end
        SetScaleformMovieAsNoLongerNeeded(scaleform2)
    end)
end)