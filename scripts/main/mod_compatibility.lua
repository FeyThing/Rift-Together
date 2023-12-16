local KnownModIndex = GLOBAL.KnownModIndex
local STRINGS = GLOBAL.STRINGS


-- Uncompromising Mode


if KnownModIndex:IsModEnabled("workshop-2039181790") then

--- Adding radiation to Uncomp
	
	AddPrefabPostInit("moonmaw_dragonfly", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
		
		----
		
		 inst.inflictvictim = function(inst, attacker)
        if attacker and attacker.components.health and not attacker.components.health:IsDead() then
            SpawnPrefab("radiation_clouds"):AlignToTarget(inst, attacker, true)					
        end
    end
    
    inst:ListenForEvent("onattackother", function(inst, data)
        if math.random() <= 0.75 and data.target then
            inst:inflictvictim(data.target)
			data.target.components.radiation:DoDelta(25)
            --data.target.components.health:DoDelta(-5*2)
        end
    end)
						
	end)
	
	AddPrefabPostInit("honey_log", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -15
	end)	
	
	AddPrefabPostInit("armor_glassmail", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.equippable:SetRadiationProtectPercent(0.15)
	end)
	
end


--- Cherry Forest

if KnownModIndex:IsModEnabled("workshop-1289779251") then
	-- Adding Radiation to Cherry Forest.
	AddPrefabPostInit("bismuthhat", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.equippable:SetRadiationProtectPercent(0.15)
	end)
	
	AddPrefabPostInit("armorbismuth", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.equippable:SetRadiationProtectPercent(0.15)
	end)

	AddPrefabPostInit("cherry", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -1
	end)	
	
		AddPrefabPostInit("cherry_cooked", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -2
	end)
	
	
end