return function(inst)
    if inst.prefab == "wx78" then
        inst:AddTag("robot")
    end
    
    --CLIENT
    if not TheWorld.ismastersim then
        return
    end
    --SERVER
    inst:AddComponent("radiation")
    inst.components.radiation:SetMax(TUNING.CHARACTERS_RADIATION[string.upper(inst.prefab)] or TUNING.CHARACTERS_RADIATION.WILSON)
    if inst:HasTag("robot") then
        inst.components.radiation:SetResistance(TUNING.ROBOT_RADIATION_RESISTANCE)
    end
end