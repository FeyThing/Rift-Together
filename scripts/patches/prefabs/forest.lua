return function(inst)
	
	--CLIENT

	if not TheNet:IsDedicated() and TUNING.RIFT_TOGETHER_OST then
        inst:AddComponent("rt_music")
    end
	if not TheWorld.ismastersim then
		return
	end
	--SERVER

end
