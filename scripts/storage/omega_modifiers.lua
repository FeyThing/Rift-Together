local containers = require "containers"

local function IsCryo(item)
    return item.prefab == "cryomod"
end

local function IsNapalm(item)
    return item.prefab == "napalmmod"
end

local function IsShock(item)
    return item.prefab == "shockmod"
end


local function omega_modifiers(inst, attacker, target)	
	
--- Cryo Modification

if inst.components.container ~= nil and inst.components.container:FindItem(IsCryo) ~= nil then
			--inst.components.container:ConsumeByName("cryomod", 1)			
if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end

    if target.components.burnable ~= nil then
        if target.components.burnable:IsBurning() then
            target.components.burnable:Extinguish()
        elseif target.components.burnable:IsSmoldering() then
            target.components.burnable:SmotherSmolder()
        end
    end

    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

    if target.sg ~= nil and not target.sg:HasStateTag("frozen") then
        target:PushEvent("attacked", { attacker = attacker, damage = 0, weapon = inst })
    end

    if target.components.freezable ~= nil then
        target.components.freezable:AddColdness(0.50)
        target.components.freezable:SpawnShatterFX()
    end
end


--- Napalm Modification

if inst.components.container ~= nil and inst.components.container:FindItem(IsNapalm) ~= nil then
			--inst.components.container:ConsumeByName("napalmmod", 1)	
		SpawnPrefab("firesplash_fx").Transform:SetPosition(target.Transform:GetWorldPosition())	
if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end	
	
    if target.components.burnable ~= nil and not target.components.burnable:IsBurning() then
        if target.components.freezable ~= nil and target.components.freezable:IsFrozen() then
            target.components.freezable:Unfreeze()
        elseif target.components.fueled == nil
            or (target.components.fueled.fueltype ~= FUELTYPE.BURNABLE and
                target.components.fueled.secondaryfueltype ~= FUELTYPE.BURNABLE) then
            --does not take burnable fuel, so just burn it
            if target.components.burnable.canlight or target.components.combat ~= nil then
                target.components.burnable:Ignite(true)
            end
        elseif target.components.fueled.accepting then
            --takes burnable fuel, so fuel it
            local fuel = SpawnPrefab("cutgrass")
            if fuel ~= nil then
                if fuel.components.fuel ~= nil and
                    fuel.components.fuel.fueltype == FUELTYPE.BURNABLE then
                    target.components.fueled:TakeFuelItem(fuel)
                else
                    fuel:Remove()
                end
            end
        end
	end	

    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

attacker.SoundEmitter:PlaySound("dontstarve/wilson/fireball_explo")


if target.components.freezable ~= nil then
        target.components.freezable:AddColdness(-1) --Does this break ice staff?
        if target.components.freezable:IsFrozen() then
            target.components.freezable:Unfreeze()
        end
    end


    target:PushEvent("attacked", { attacker = attacker, damage = 0, weapon = inst })
end


--- Shock Modification

if inst.components.container ~= nil and inst.components.container:FindItem(IsShock) ~= nil then
			--inst.components.container:ConsumeByName("shockmod", 1)	
			
if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end

if target ~= nil and target:IsValid() and attacker ~= nil and attacker:IsValid() then		
        SpawnPrefab("electrichitsparks"):AlignToTarget(target, attacker, true)		
    end
	if target.components.health and not target.components.health:IsDead() then
				target.components.health:DoDelta(-10)
			end
	
if target:HasTag("wet") then
		target.components.combat:GetAttacked(attacker, 8, inst)--8 is the bonus damage + the normal weapon damage
	end

end
	
end

	


return omega_modifiers