local assets =
{
	Asset("ANIM", "anim/rarisword.zip"),
	Asset("ANIM", "anim/swap_rarisword.zip"),
	Asset("ANIM", "anim/ui_alterguardianhat_1x1.zip"),

}

local prefabs =
{
    "electrichitsparks",
}

local function IsCryo(item) return item.prefab == "cryomod" end
local function IsNapalm(item) return item.prefab == "napalmmod" end
local function IsShock(item) return item.prefab == "shockmod" end

local function CryoModification(inst, attacker, target)
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

local function NapalmModification(inst, attacker, target)
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

local function ShockModification(inst, attacker, target)
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

local function omega_modifiers(inst, attacker, target)	
    if inst.components.container ~= nil and inst.components.container:FindItem(IsCryo) ~= nil then
        CryoModification(inst, attacker, target)
    end

    if inst.components.container ~= nil and inst.components.container:FindItem(IsNapalm) ~= nil then
        NapalmModification(inst, attacker, target)
    end

    if inst.components.container ~= nil and inst.components.container:FindItem(IsShock) ~= nil then
        ShockModification(inst, attacker, target)
    end
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_rarisword", "swap_rarisword")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")
	if inst.components.container ~= nil then
        inst.components.container:Close()
    end	
end

local function OnEquipToModel(inst, owner)
    if inst.components.container ~= nil then
        inst.components.container:Close()
    end
end

local function OnAttack(inst, attacker, target)
    if target:HasTag("chess") then
		target.components.combat:GetAttacked(attacker, 50, inst)
	end

    omega_modifiers(inst, attacker, target)	
end


local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("rarisword")
    inst.AnimState:SetBuild("rarisword")
    inst.AnimState:PlayAnimation("idle")
	

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddTag("weaponmod")
    inst:AddTag("sharp")

    inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(35)
    inst.components.weapon:SetOnAttack(OnAttack)
    -------    

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "rarisword"
    inst.components.inventoryitem.atlasname = "images/rnc_inventoryimages.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable:SetOnEquipToModel(OnEquipToModel)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.FENCE_ROTATOR_USES)
    inst.components.finiteuses:SetUses(TUNING.FENCE_ROTATOR_USES)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("rarisword")

    MakeHauntableLaunch(inst)
	
    return inst
end

return Prefab("rarisword", fn, assets)