return function(self)
	local AMBIENT_SOUNDS = UpvalueHacker.GetUpvalue(self.OnUpdate, "AMBIENT_SOUNDS")

    AMBIENT_SOUNDS[WORLD_TILES.JUNK] = {sound = "dontstarve/AMB/badland", wintersound = "dontstarve/AMB/badland_winter", springsound = "dontstarve/AMB/badland", summersound = "dontstarve_DLC001/AMB/badland_summer", rainsound = "dontstarve/AMB/badland_rain"}
    AMBIENT_SOUNDS[WORLD_TILES.DESERTSAND] = {sound = "dontstarve/AMB/badland", wintersound = "dontstarve/AMB/badland_winter", springsound = "dontstarve/AMB/badland", summersound = "dontstarve_DLC001/AMB/badland_summer", rainsound = "dontstarve/AMB/badland_rain"}
end
