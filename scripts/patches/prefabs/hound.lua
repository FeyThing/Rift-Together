return function(inst)

	if not TheWorld.ismastersim then
		return
	end
	
	inst.inflictvictim = function(inst, attacker)
        if attacker and attacker.components.health and not attacker.components.health:IsDead() then
            SpawnPrefab("radiation_clouds"):AlignToTarget(inst, attacker, true)					
        end
    end
	
	inst:ListenForEvent("onattackother", function(inst, data)	
        if math.random() <= 0.9 and data.target and not data.target:HasTag("radiationimmunity")  then
            inst:inflictvictim(data.target)
			data.target.components.radiation:DoDelta(10)
        end
    end)

end