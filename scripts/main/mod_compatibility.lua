local KnownModIndex = GLOBAL.KnownModIndex
local STRINGS = GLOBAL.STRINGS


-- Uncompromising Mode


if TUNING.RT_UNCOMP and KnownModIndex:IsModEnabled("workshop-2039181790") then

--- Setting radiation value for UM characters

	local characters = {
	WINKY = 120,
    WATHOM = 150,
    WIXIE = 100
}

for k, v in pairs(characters) do
	AddPrefabPostInit(v, function(inst)
		inst.components.radiation:SetMax(TUNING.CHARACTERS_RADIATION.characters)
	end)
end


--- Adding radiation to Uncomp
	
	
	AddPrefabPostInit("moonmaw_dragonfly", function(inst)
	
	
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
				
	inst.inflictvictim = function(inst, attacker)
        if attacker and attacker.components.health and not attacker.components.health:IsDead() then
            SpawnPrefab("radiation_clouds"):AlignToTarget(inst, attacker, true)					
        end
    end	 	
    
    inst:ListenForEvent("onattackother", function(inst, data)
        if math.random() <= 0.75 and data.target and not data.target:HasTag("radiationimmunity") then
            inst:inflictvictim(data.target)
			data.target.components.radiation:DoDelta(25)
        end
    end)
						
	end)
	
	AddPrefabPostInit("moonmaw_larvae", function(inst)
	
	
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
				
		--- radiation damage 
	
	inst.inflictvictim = function(inst, attacker)
        if attacker and attacker.components.health and not attacker.components.health:IsDead() then
            SpawnPrefab("radiation_clouds"):AlignToTarget(inst, attacker, true)					
        end
    end
	
    inst:ListenForEvent("onattackother", function(inst, data)
        if math.random() <= 0.9 and data.target and not data.target:HasTag("radiationimmunity") then
            inst:inflictvictim(data.target)
			data.target.components.radiation:DoDelta(10)
        end
    end)
						
	end)
	
	AddPrefabPostInit("moonmaw_glass", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	
	inst:AddComponent("radiationspreader")
    inst.components.radiationspreader:SetRadius(1)
	

	end)
	
	AddPrefabPostInit("moonmaw_trap", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	
	inst:AddComponent("radiationspreader")
    inst.components.radiationspreader:SetRadius(2)
	

	end)
	
	AddPrefabPostInit("moonmaw_glasshards", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
		
	inst.inflictvictim = function(inst, attacker)
        if attacker and attacker.components.health and not attacker.components.health:IsDead() then
            SpawnPrefab("radiation_clouds"):AlignToTarget(inst, attacker, true)					
        end
    end
	   
    inst:ListenForEvent("onattackother", function(inst, data)
        if math.random() <= 0.9 and data.target and not data.target:HasTag("radiationimmunity") then
            inst:inflictvictim(data.target)
			data.target.components.radiation:DoDelta(1)
        end
    end)
	

	end)
	
	AddPrefabPostInit("hound", function(inst)
		if inst:HasTag("horrorhound") then	
		
		inst.inflictvictim = function(inst, attacker)
        if attacker and attacker.components.health and not attacker.components.health:IsDead() then
            SpawnPrefab("radiation_clouds"):AlignToTarget(inst, attacker, true)					
        end
        end
		
		inst:ListenForEvent("onattackother", function(inst, data)
        if math.random() <= 0.9 and data.target and not data.target:HasTag("radiationimmunity") then
            inst:inflictvictim(data.target)
			data.target.components.radiation:DoDelta(10)
        end
    end)
		
		end
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

if TUNING.RT_CHERRY and KnownModIndex:IsModEnabled("workshop-1289779251") then
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
	
	-- Immune
	
	AddPrefabPostInit("cherry_daylily", function(inst)
		inst:AddTag("radiationimmunity")			
	end)
	
	
end

--- Island Adventures


if TUNING.RT_ISLAND and KnownModIndex:IsModEnabled("workshop-1467214795") then

	--- Setting radiation value for IA characters

	local characters = {
	WALANI = 100,
    WILBER = 100,
	WOODLEGS = 150
}

for k, v in pairs(characters) do
	AddPrefabPostInit(v, function(inst)
		inst.components.radiation:SetMax(TUNING.CHARACTERS_RADIATION.characters)
	end)
end


	-- Adding Radiation to Island Adventures.

	AddPrefabPostInit("bananapop", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = 5
	end)	
	
	
	-- Rift Together Luminous tree compatibility
	
	TUNING.LUMINOUS_WINDBLOWN_SPEED = 0.2
	TUNING.LUMINOUS_WINDBLOWN_FALL_CHANCE = 0
	
	AddPrefabPostInit("luminoustree", function(inst)
		inst:AddTag("gustable")
		
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
		
		GLOBAL.MakeTreeBlowInWindGust(inst, TUNING.LUMINOUS_WINDBLOWN_SPEED, TUNING.LUMINOUS_WINDBLOWN_FALL_CHANCE)
	end)
	
	
	
end

--- Dehydration Mode

if TUNING.RT_DEHYDRATED and KnownModIndex:IsModEnabled("workshop-3004639365") then


	-- Adding Radiation to Dehydrated Mode.

	AddPrefabPostInit("spoiled_drink", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = 5
	end)

	AddPrefabPostInit("water_dirty_ice", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = 10
	end)	
	
	AddPrefabPostInit("water_dirty", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = 8
	end)	
	
	AddPrefabPostInit("goopydrink", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = 2
	end)
	
	AddPrefabPostInit("banana_juice", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = 2
	end)
	
	AddPrefabPostInit("pomegranate_juice", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -5
	end)
	
	AddPrefabPostInit("tomato_juice", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -5
	end)
	
	AddPrefabPostInit("greentea", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -10
	end)
	
	AddPrefabPostInit("blacktea", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -8
	end)
	
	AddPrefabPostInit("blacktea_iced", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -10
	end)

	AddPrefabPostInit("hibiscustea", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -10
	end)
	
	AddPrefabPostInit("sushibiscus", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = 6
	end)
	
	AddPrefabPostInit("cactusflower_tea", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -10
	end)
	
	AddPrefabPostInit("lotustea", function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
	inst.components.edible.radiationvalue = -15
	end)
	
	
end