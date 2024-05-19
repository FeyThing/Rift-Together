return function(inst)
    -- CLIENT
    if inst:IsValid() and inst.components and inst.components.health and inst:HasTag("lunar_aligned") then
        inst:AddTag("radiationimmunity")
    end

    if not _G.TheWorld.ismastersim then
        return
    end
    
    -- SERVER
	if inst:IsValid() and inst.components and inst.components.health and not inst.components.radiation then
        inst:AddComponent("radiation")
        inst.components.radiation:SetMax(TUNING.MAX_RADIATION_DEFAULT)
	end
end