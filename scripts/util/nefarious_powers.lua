
--Nefarious Power related things
local function baseFn(inst)
    TUNING.NEFARIOUS_ENERGY_COST = 1
	inst.components.combat:SetDefaultDamage(10)
	inst.components.combat.damagemultiplier = 1
	inst.components.combat:SetRange(3)
	inst.components.health.absorb = (TUNING.NEFARIOUS_HEALTH_ABSORB)
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 6
end

local function removeStealthFn(inst)	
	inst.stealth = nil
	baseFn(inst)
	inst:RemoveTag("notarget")
	inst:AddTag("scarytoprey")
	inst:RemoveTag("istransparent")
	inst.AnimState:SetMultColour(1, 1, 1, 1)
	if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
end

local function removeCombatFn(inst, period)	
	inst.combat = nil
	inst:SetStateGraph("SGwilson")
	inst.AnimState:SetBank("wilson")
	inst:RemoveTag("annihilator")
	inst:RemoveTag("sharp")
	--inst.sg:GoToState("powerdown")
	baseFn(inst)	
	inst.SoundEmitter:PlaySound("dontstarve/creatures/bishop/charge")
	--inst.AnimState:ClearBloomEffectHandle()	
	if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
	
end

local function removeShieldFn(inst)	
	inst.shielding = nil
	baseFn(inst)
	inst.Light:Enable(false)
	inst:RemoveTag("forcefield")
	inst.forcefieldfx1:kill_fx() -- This is how we access the kill_fx method of the forcefieldfx prefab
	inst.components.playervision.forcegogglevision = false
	SpawnPrefab("wx78_big_spark"):AlignToTarget(inst)	
	inst.SoundEmitter:PlaySound("dontstarve/creatures/bishop/charge")			
	inst.AnimState:ClearBloomEffectHandle()
	if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
	
end

local function drainenergy(inst)
	TUNING.NEFARIOUS_ENERGY_COST = 0
    if inst.components.nefarious_energy then
	if inst.stealth or inst.shielding or inst.combat then
        inst.components.nefarious_energy:DoDec(1) 	
    end
	end
	if inst.stealth and inst.components.nefarious_energy:GetPercent() <= 0 then 
		local x, y, z = inst.Transform:GetWorldPosition()
		SpawnPrefab("sparks").Transform:SetPosition(x, y + 1 + math.random() * 1.5, z)
		removeStealthFn(inst)
		elseif inst.combat and inst.components.nefarious_energy:GetPercent() <= 0 then 
		local x, y, z = inst.Transform:GetWorldPosition()
		SpawnPrefab("sparks").Transform:SetPosition(x, y + 1 + math.random() * 1.5, z)		
		removeCombatFn(inst)
		inst.sg:GoToState("powerdown")
		elseif inst.shielding and inst.components.nefarious_energy:GetPercent() <= 0 then  
		inst.sg:GoToState("electrocute") -- Changed this so it goes directly to state without waiting for idle anims to end
		removeShieldFn(inst)
		end				
	end 	

	

--STEALTH ABILITY
----------------------------------------------------------------------------------------------------------------------------------------------------------

local function DropTargets(inst)
	local x,y,z = inst.Transform:GetWorldPosition()	
	local ents = TheSim:FindEntities(x, y, z, 50)

	for k,v in pairs(ents) do
		if v.components.combat and v.components.combat.target == inst then
			v.components.combat.target = nil
		end
	end
end

local AGGR_TIME = 3


local function stealthFn(inst, period)
if inst:HasTag("playerghost") then return end
 
if inst.transformed then 
if inst.stealth then 
	        removeStealthFn(inst)	
			else	
			if inst.shielding or inst.combat then return end			
			inst.stealth = true
			inst.components.combat.damagemultiplier = .10
			inst.components.health.absorb = (TUNING.NEFARIOUS_HEALTH_ABSORB)
			inst:AddTag("notarget")
	        inst:RemoveTag("scarytoprey")
			inst:AddTag("istransparent")
			inst.AnimState:SetMultColour(1, 1, 1, 0.3) 
			inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn")
			inst.components.talker:Say("Deploying stealth protocol!")			
			inst.task = inst:DoPeriodicTask(1, drainenergy, nil, inst)
			
	end				
    end    	
	  
	local timer = 0
	inst.task_drop_targets = inst:DoPeriodicTask(0.2,function(inst)
		timer = timer + 0.2
		if timer > AGGR_TIME then
			DropTargets(inst)
		end
		if inst.task_drop_targets and (timer > AGGR_TIME or not inst.stealth)  then
			inst.task_drop_targets:Cancel()
			inst.task_drop_targets = nil
		end
	end)


inst.transformed = not inst.transformed
 
return true
 
 
end



--COMBAT ABILITY
----------------------------------------------------------------------------------------------------------------------------------------------------------


 local function combatFn(inst)
 
if inst:HasTag("playerghost") then return end
 
if inst.transformed then 
if inst.combat then 			
            removeCombatFn(inst)						
	else
	if inst.shielding or inst.stealth then return end			
			inst.combat = true
			--inst.sg:GoToState("powerup")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bishop/shoot")
			inst.components.talker:Say("Initiating combat sequence!")
			inst:AddTag("annihilator")
			inst:AddTag("sharp")
			inst:SetStateGraph("SGannihilator")
			inst.AnimState:SetBuild("nefarious")
			inst.AnimState:SetBank("nefarious")
			--inst.AnimState:OverrideSymbol("run_loop", "nefarious", "run_loop")
			--inst.AnimState:OverrideSymbol("atk", "nefarious", "atk")			
			inst.components.health.absorb = (2 * TUNING.NEFARIOUS_HEALTH_ABSORB)
			inst.components.combat:SetDefaultDamage(34) 
			inst.components.combat.damagemultiplier = 2
			inst.components.combat:SetRange(5)
			inst.components.locomotor.walkspeed = 6
		    inst.components.locomotor.runspeed = 8
			--inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh") 
			inst.task = inst:DoPeriodicTask(1, drainenergy, nil, inst)
	
	end

	
 end


inst.transformed = not inst.transformed
 
return true

 
end


--SHIELDING ABILITY
----------------------------------------------------------------------------------------------------------------------------------------------------------

 

 local function shieldingFn(inst)
 
if inst:HasTag("playerghost") then return end
 
if inst.transformed then
if inst.shielding then 		
            removeShieldFn(inst)						
	    else
		if inst.combat or inst.stealth then return end
            inst.shielding = true
            inst.Light:Enable(true)
            inst.Light:SetRadius(3) 
            inst:AddTag("forcefield")
            inst.forcefieldfx1 = _G.SpawnPrefab("forcefieldfx1") -- "Attach" the fx to the inst
            inst.forcefieldfx1.entity:SetParent(inst.entity) -- So we don't have to loop through the children to find it later to kill it
            inst.forcefieldfx1.Transform:SetPosition(0, 0.2, 0)
            inst.components.health.absorb = (3 * TUNING.NEFARIOUS_HEALTH_ABSORB)
            inst.components.combat.damagemultiplier = .25
			inst.components.playervision.forcegogglevision = true
            inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh") 
            inst.sg:GoToState("powerup") 
            inst.SoundEmitter:PlaySound("dontstarve/creatures/bishop/shoot")
            inst.components.talker:Say("Activating Shields!") 
			inst.task = inst:DoPeriodicTask(1, drainenergy, nil, inst)
        
 end

end		
 
inst.transformed = not inst.transformed
return true
 
end

AddModRPCHandler("nefarious", "STEALTH", stealthFn)
AddModRPCHandler("nefarious", "COMBAT", combatFn)
AddModRPCHandler("nefarious", "SHIELDING", shieldingFn)