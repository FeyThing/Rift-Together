return function(inst)

	if not _G.TheWorld.ismastersim then
		return
	end
	
	inst:AddComponent("armoredbody")
	
	inst.inflictvictim = function(inst, attacker)
        if attacker and attacker.components.health and not attacker.components.health:IsDead() then
            _G.SpawnPrefab("radiation_clouds"):AlignToTarget(inst, attacker, true)					
        end
    end
	
	inst:ListenForEvent("onattackother", function(inst, data)	
        if math.random() <= 0.8 and data.target and data.target.components.radiation then
            inst:inflictvictim(data.target)
			data.target.components.radiation:DoDelta(25)
        end
    end)
end