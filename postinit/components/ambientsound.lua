local TORRENIV_AMBIENT_SOUND =
{
	--[[[WORLD_TILES.JUNK_NOISE] = {sound = "dontstarve/AMB/badland", wintersound = "dontstarve/AMB/badland_winter", springsound = "dontstarve/AMB/badland", summersound = "dontstarve_DLC001/AMB/badland_summer", rainsound = "dontstarve/AMB/badland_rain"},]]
	[WORLD_TILES.JUNK] = {sound = "dontstarve/AMB/badland", wintersound = "dontstarve/AMB/badland_winter", springsound = "dontstarve/AMB/badland", summersound = "dontstarve_DLC001/AMB/badland_summer", rainsound = "dontstarve/AMB/badland_rain"},
	[WORLD_TILES.DESERTSAND] = {sound = "dontstarve/AMB/badland", wintersound = "dontstarve/AMB/badland_winter", springsound = "dontstarve/AMB/badland", summersound = "dontstarve_DLC001/AMB/badland_summer", rainsound = "dontstarve/AMB/badland_rain"},
}

function TorrenUpvalue(fn, upvalue_name)
	i = 1
	while true do
		local val, v = GLOBAL.debug.getupvalue(fn, i)
		if not val then
			break
		end
		if val == upvalue_name then
			return v, i
		end
		i = i + 1
	end
end

AddComponentPostInit("ambientsound", function(self)
	local AMBIENT_SOUNDS, SOUND = TorrenUpvalue(self.OnUpdate, "AMBIENT_SOUNDS")
	if SOUND then
		for k, v in pairs(TORRENIV_AMBIENT_SOUND) do
			AMBIENT_SOUNDS[k] = TORRENIV_AMBIENT_SOUND[k]
		end
	end
end)