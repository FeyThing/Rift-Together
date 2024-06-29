local function IsValidRadiationEntity(inst)
    return not (inst:HasTag("boat") or
                inst:HasTag("wall") or
                inst:HasTag("noradiation"))
end

local function ShouldStartWithRadiationIgnored(inst)
    return inst:HasTag("lunar_aligned")
end

local DamageTypesUtil = require("main/damagetypesutil")
return function(inst)
    -- SERVER & CLIENT
    if not _G.TheWorld.ismastersim then
        return
    end
    -- SERVER
    -- Radiation
    if inst:IsValid() and inst.components and not inst.components.radiation and inst.components.health and IsValidRadiationEntity(inst) then
        inst:AddComponent("radiation")
        inst.components.radiation:SetMax(TUNING.MAX_RADIATION_DEFAULT)
        if ShouldStartWithRadiationIgnored(inst) then
            inst.components.radiation:SetIgnore(true)
        end
    end
  
    -- Damage types
    if not DamageTypesUtil.ShouldSkip(inst) then
        local weapon_cmp = inst.components.weapon
        local armor_cmp = inst.components.armor
        local combat_cmp = inst.components.combat

        if weapon_cmp ~= nil or armor_cmp ~= nil then
            -- Doing weapon and armor together because items like the Shield of Terror exist
            if weapon_cmp ~= nil then
                DamageTypesUtil.WeaponAttackModifiers(inst, weapon_cmp)
            end

            if armor_cmp ~= nil then
                DamageTypesUtil.ArmorDefenseModifiers(inst, armor_cmp)
            end
        elseif combat_cmp ~= nil then
            DamageTypesUtil.EntityAttackModifiers(inst, combat_cmp)
            DamageTypesUtil.EntityDefenseModifiers(inst, combat_cmp)
        end
    end
end