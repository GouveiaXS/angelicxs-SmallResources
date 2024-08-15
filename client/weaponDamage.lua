-- Weapons Damage; modifier = 1.0 is default. Go below 1.0 and the damage will be reduced, go above 1.0 and damage will become higher.
-- Set disableCriticalHits to true to disable. Set it to false to enable.

local WeaponsDamage = {
    [`WEAPON_UNARMED`] = {model = `WEAPON_UNARMED`, modifier = 0.4, disableCriticalHits = true},
    [`WEAPON_FLASHLIGHT`] = {model = `WEAPON_NIGHTSTICK`, modifier = 0.4, disableCriticalHits = true},
    [`WEAPON_KNIFE`] = {model = `WEAPON_KNIFE`, modifier = 0.4, disableCriticalHits = true},
    [`WEAPON_KNUCKLE`] = {model = `WEAPON_KNUCKLE`, modifier = 0.4, disableCriticalHits = true},
    [`WEAPON_NIGHTSTICK`] = {model = `WEAPON_NIGHTSTICK`, modifier = 0.4, disableCriticalHits = true},
    [`WEAPON_HAMMER`] = {model = `WEAPON_HAMMER`, modifier = 0.4, disableCriticalHits = true},
    [`WEAPON_BAT`] = {model = `WEAPON_BAT`, modifier = 0.4, disableCriticalHits = true},
    [`WEAPON_GOLFCLUB`] = {model = `WEAPON_GOLFCLUB`, modifier = 0.6, disableCriticalHits = true},
    [`WEAPON_CROWBAR`] = {model = `WEAPON_CROWBAR`, modifier = 0.6, disableCriticalHits = true},
    [`WEAPON_BOTTLE`] = {model = `WEAPON_BOTTLE`, modifier = 0.6, disableCriticalHits = true},
    [`WEAPON_DAGGER`] = {model = `WEAPON_DAGGER`, modifier = 0.6, disableCriticalHits = true},
    [`WEAPON_HATCHET`] = {model = `WEAPON_HATCHET`, modifier = 0.5, disableCriticalHits = true},
    [`WEAPON_MACHETE`] = {model = `WEAPON_MACHETE`, modifier = 0.5, disableCriticalHits = true},
    [`WEAPON_SWITCHBLADE`] = {model = `WEAPON_SWITCHBLADE`, modifier = 0.5, disableCriticalHits = true},
    [`WEAPON_PROXMINE`] = {model = `WEAPON_PROXMINE`, modifier = 1.5, disableCriticalHits = true},
    [`WEAPON_BZGAS`] = {model = `WEAPON_BZGAS`, modifier = 0.1, disableCriticalHits = true},
    [`WEAPON_SMOKEGRENADE`] = {model = `WEAPON_SMOKEGRENADE`, modifier = 0.1, disableCriticalHits = true},
    [`WEAPON_MOLOTOV`] = {model = `WEAPON_MOLOTOV`, modifier = 1.0, disableCriticalHits = true},
    [`WEAPON_REVOLVER`] = {model = `WEAPON_REVOLVER`, modifier = 0.1, disableCriticalHits = true},
    [`WEAPON_POOLCUE`] = {model = `WEAPON_POOLCUE`, modifier = 0.4, disableCriticalHits = true},
    [`WEAPON_PIPEWRENCH`] = {model = `WEAPON_PIPEWRENCH`, modifier = 0.6, disableCriticalHits = true},
    [`WEAPON_PISTOL`] = {model = `WEAPON_PISTOL`, modifier = 0.7, disableCriticalHits = true},                  ---in use
    [`WEAPON_PISTOL_MK2`] = {model = `WEAPON_PISTOL_MK2`, modifier = 1.0, disableCriticalHits = true},          ---pd pistol
    [`WEAPON_COMBATPISTOL`] = {model = `WEAPON_COMBATPISTOL`, modifier = 1.0, disableCriticalHits = true},
    [`WEAPON_APPISTOL`] = {model = `WEAPON_APPISTOL`, modifier = 0.7, disableCriticalHits = true},              ---gun bench
    [`WEAPON_PISTOL50`]              = {model = `WEAPON_PISTOL50`, modifier = 1.4, disableCriticalHits = true},
    [`WEAPON_SNSPISTOL`]             = {model = `WEAPON_SNSPISTOL`, modifier = 1.0, disableCriticalHits = true},
    [`WEAPON_HEAVYPISTOL`]           = {model = `WEAPON_HEAVYPISTOL`, modifier = 0.1, disableCriticalHits = true},
    [`WEAPON_VINTAGEPISTOL`]         = {model = `WEAPON_VINTAGEPISTOL`, modifier = 0.8, disableCriticalHits = true},
    [`WEAPON_FLAREGUN`]              = {model = `WEAPON_FLAREGUN`, modifier = -0.5, disableCriticalHits = true},
    [`WEAPON_MARKSMANPISTOL`]        = {model = `WEAPON_MARKSMANPISTOL`, modifier = 0.1, disableCriticalHits = true},
    [`WEAPON_MICROSMG`]              = {model = `WEAPON_MICROSMG`, modifier = 0.5, disableCriticalHits = true},
    [`WEAPON_MINISMG`]               = {model = `WEAPON_MINISMG`, modifier = 0.5, disableCriticalHits = true},
    [`WEAPON_SMG`]                   = {model = `WEAPON_SMG`, modifier = 0.5, disableCriticalHits = true},
    [`WEAPON_SMG_MK2`]               = {model = `WEAPON_SMG_MK2`, modifier = 0.8, disableCriticalHits = true},      --pd smg
    [`WEAPON_ASSAULTSMG`]            = {model = `WEAPON_ASSAULTSMG`, modifier = 1.0, disableCriticalHits = true},
    [`WEAPON_MG`]                    = {model = `WEAPON_MG`, modifier = 0.1, disableCriticalHits = true},
    [`WEAPON_COMBATMG`]              = {model = `WEAPON_COMBATMG`, modifier = 0.1, disableCriticalHits = true},
    [`WEAPON_COMBATMG_MK2`]          = {model = `WEAPON_COMBATMG_MK2`, modifier = 0.1, disableCriticalHits = true},
    [`WEAPON_COMBATPDW`]             = {model = `WEAPON_COMBATPDW`, modifier = 0.5, disableCriticalHits = true},
    [`weapon_pumpshotgun`]           = {model = `weapon_pumpshotgun`, modifier = 0.3, disableCriticalHits = true},                ----in use
    [`weapon_pumpshotgun_mk2`]       = {model = `weapon_pumpshotgun_mk2`, modifier = 0.5, disableCriticalHits = true},        ----pd shotgun
    [`weapon_dbshotgun`]             = {model = `weapon_dbshotgun`, modifier = 0.4, disableCriticalHits = true},
    [`weapon_assaultrifle`]          = {model = `weapon_assaultrifle`, modifier = 0.4, disableCriticalHits = true},
    [`weapon_carbinerifle_mk2`]      = {model = `weapon_carbinerifle_mk2`, modifier = 0.6, disableCriticalHits = true},
    [`weapon_compactrifle`]          = {model = `weapon_compactrifle`,     modifier = 0.5, disableCriticalHits = true},
    [`weapon_doubleaction`]          = {model = `weapon_doubleaction`,     modifier = 0.5, disableCriticalHits = true},
    [`weapon_machinepistol`]         = {model = `weapon_machinepistol`,    modifier = 0.5, disableCriticalHits = true},
    ['weapon_acro'] 		 		 = {model = 'weapon_acro', 	 	       modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_ak47'] 		 		 = {model = 'weapon_ak47', 	 	    modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_ar15'] 				 = {model = 'weapon_ar15', 	 	 	modifier = 0.9,  disableCriticalHits = true},	
    ['weapon_bayonet'] 				 = {model = 'weapon_bayonet', 	    modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_de'] 					 = {model = 'weapon_de', 			modifier = 0.0, 	 disableCriticalHits = true},	---- secret bench
    ['weapon_fnx45'] 				 = {model = 'weapon_fnx45', 	 	modifier = 0.1, 	 disableCriticalHits = true},	
    ['weapon_glock17'] 				 = {model = 'weapon_glock17', 		modifier = 1.0, 	 disableCriticalHits = true},	
    ['weapon_glockkit'] 			 = {model = 'weapon_glockkit', 		modifier = 0.1, 	 disableCriticalHits = true},	
    ['weapon_hipoint'] 				 = {model = 'weapon_hipoint', 	    modifier = 0.1, 	 disableCriticalHits = true},	
    ['weapon_huntingrifle'] 		 = {model = 'weapon_huntingrifle', 	modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_m4'] 					 = {model = 'weapon_m4', 	 	    modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_m9'] 					 = {model = 'weapon_m9', 		    modifier = 0.1, 	 disableCriticalHits = true},	
    ['weapon_m70'] 					 = {model = 'weapon_m70', 	 	    modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_m1911'] 				 = {model = 'weapon_m1911', 	 	modifier = 0.1, 	 disableCriticalHits = true},	
    ['weapon_mac10'] 				 = {model = 'weapon_mac10', 		modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_mk14'] 				 = {model = 'weapon_mk14', 	 	    modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_mossberg'] 			 = {model = 'weapon_mossberg',      modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_remington'] 			 = {model = 'weapon_remington', 	modifier = 0.1, 	 disableCriticalHits = true},	
    ['weapon_scarh'] 				 = {model = 'weapon_scarh', 		modifier = 0.1,  disableCriticalHits = true},	
    ['weapon_draco'] 				 = {model = 'weapon_draco', 	    modifier = 0.1, 	 disableCriticalHits = true},	
    ['weapon_shiv'] 				 = {model = 'weapon_shiv', 			modifier = 0.2, 	 disableCriticalHits = true},	  -- gun bench
    ['weapon_uzi'] 					 = {model = 'weapon_uzi', 			modifier = 0.1,  disableCriticalHits = true},	
}
CreateThread(function()
    while true do
        Wait(0)
        for k,v in pairs (WeaponsDamage) do
            N_0x4757f00bc6323cfe(v.model, v.modifier)
            if v.disableCritical then
                SetPedSuffersCriticalHits(PlayerPedId(), false)
            end
        end
    end
end)

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        if IsEntityPlayingAnim(playerPed, 'combat@damage@writhe', 'writhe_loop', 3)	then
            if HasEntityBeenDamagedByAnyPed(playerPed) then
                SetEntityHealth(playerPed, 0)
            end
        else
            Wait(1000)
        end
        Wait(0)
    end
end)