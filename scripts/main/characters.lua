local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

if GetModConfigData("Ratchet And Clank Characters") == 1 then
		AddModCharacter("ratchet", "MALE", skin_modes)
		--AddModCharacter("nefarious", "MALE", skin_modes)

	end

