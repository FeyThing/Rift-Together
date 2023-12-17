return function(inst)

		if inst:IsValid() and inst.components and inst.components.health and inst:HasTag("lunar_aligned") then
		inst:AddTag("radiationimmunity")
		end

    --CLIENT
    if not TheWorld.ismastersim then
        return
    end

	if inst:IsValid() and inst.components and inst.components.health and not inst.components.radiation then
        inst:AddComponent("radiation")
        inst.components.radiation:SetMax(TUNING.CHARACTERS_RADIATION.WILSON)
	end
end