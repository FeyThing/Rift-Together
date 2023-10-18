local containers = require "containers"
local omegamodifier = require "storage.omega_modifiers"

local assets =
{
	Asset("ANIM", "anim/owrench.zip"),
	Asset("ANIM", "anim/swap_owrench.zip"),
	Asset("ANIM", "anim/ui_ratchet_3x1.zip"),

}

local prefabs =
{
    "electrichitsparks",
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_owrench", "swap_owrench")
	owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
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

local function OnEquipToModel(inst, owner, from_ground)
    if inst.components.container ~= nil then
        inst.components.container:Close()
    end
end


local function OnAttack(inst, attacker, target)

 if target:HasTag("chess") then
		target.components.combat:GetAttacked(attacker, 100, inst)--100 is the bonus damage + the normal weapon damage
	end

omegamodifier(inst, attacker, target)
		
end


local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("owrench")
    inst.AnimState:SetBuild("owrench")
    inst.AnimState:PlayAnimation("idle")
	

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddTag("weaponmod")
	inst:AddTag("hammer")
    inst:AddTag("sharp")

    inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(15)
    inst.components.weapon:SetOnAttack(OnAttack)
    -------
    
	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "owrench"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/owrench.xml"
	
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable.restrictedtag = "veldin_mechanic"
    inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable:SetOnEquipToModel(OnEquipToModel)  
	
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("owrench")

    MakeHauntableLaunch(inst)
    
	
    return inst
end

return Prefab("common/inventory/owrench", fn, assets)