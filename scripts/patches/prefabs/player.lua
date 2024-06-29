return function(inst)
    --CLIENT
    if inst.prefab == "wx78" then
        inst:AddTag("robot")
    end
	
    if inst.prefab == "wormwood" then
        inst:AddTag("lunar_touched")
    end
    
    if not _G.TheWorld.ismastersim then
        return
    end
    
    --SERVER
    if not inst.components.radiation then
        inst:AddComponent("radiation")
    end
    
    inst.components.radiation:SetMax(TUNING.CHARACTERS_MAX_RADIATION[string.upper(inst.prefab)] or TUNING.CHARACTERS_MAX_RADIATION.WILSON)
    if inst:HasTag("robot") or inst:HasTag("lunar_touched") then
        inst.components.radiation:SetResistance(TUNING.ROBOT_RADIATION_RESISTANCE)
    end
end