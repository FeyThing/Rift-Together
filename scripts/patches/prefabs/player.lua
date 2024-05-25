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
    inst:AddComponent("radiation")
    inst.components.radiation:SetMax(TUNING.CHARACTERS_MAX_RADIATION[string.upper(inst.prefab)] or TUNING.CHARACTERS_MAX_RADIATION.WILSON)
    if inst:HasTag("robot") or inst:HasTag("lunar_touched") then
        inst.components.radiation:SetResistance(TUNING.ROBOT_RADIATION_RESISTANCE)
    end
	
	-- For armored body
	
	-- to-do I'll do these tags properly when we have a reinforcing system
	local REINFORCED_WEAPON_TAGS = {"raritanium", "reinforced", "shadow_item", "bismuthloaded", "show_broken_ui", "guitar"}
	
	local function ShouldRecoilOnArmored(inst, weapon)
		if weapon ~= nil then
			if weapon:HasTag("rangedweapon") or weapon:HasTag("projectile") then
				return false
			elseif weapon:HasOneOfTags(REINFORCED_WEAPON_TAGS) then
				return false
			elseif weapon.components.tool ~= nil and weapon.components.tool:CanDoToughWork() then
				return false
			end
		end
		
		return true
	end
	
	local function OnAttackOther(inst, data)
		if inst:HasTag("toughworker") or inst:HasTag("weremoose") or (inst.components.rider ~= nil and inst.components.rider:IsRiding()) then
			return
		end
		
		if data.target ~= nil and data.target:HasTag("armoredbody") and ShouldRecoilOnArmored(inst, data.weapon) then
			if data.weapon ~= nil and data.weapon.components.finiteuses ~= nil then
				-- This modifier is removed after the durability is consumed (patches/components/weapon)
				data.weapon.components.weapon.attackwearmultipliers:SetModifier(data.weapon, TUNING.ARMOREDBODY_ATTACKWEAR_MULT, "armoredbody_attackwear")
				
				inst.SoundEmitter:PlaySound("dontstarve/wilson/use_break")
				SpawnPrefab("brokentool").Transform:SetPosition(data.target.Transform:GetWorldPosition())
			end
			
			local state = "mine_recoil"
			
			if inst:HasTag("beaver") then
				state = "gnaw_recoil"
			end
			
			if inst.sg ~= nil and not inst.sg:HasAnyStateTag("nointerrupt", "dead") then
				inst.sg:GoToState(state, { target = data.target })
			end
		end
	end
	
	inst:ListenForEvent("onattackother", OnAttackOther)
end