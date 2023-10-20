return function(inst)
    inst:AddComponent("radiation")
    inst.components.radiation:SetMax(TUNING.CHARACTERS_RADIATION[string.upper(inst.prefab)] or TUNING.CHARACTERS_RADIATION.WILSON)
end