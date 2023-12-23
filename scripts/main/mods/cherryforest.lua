-- Adding Radiation to Cherry Forest.

AddPrefabPostInit("whirlywings", function(inst)
   inst.components.radiation:SetMax(150)
end)

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