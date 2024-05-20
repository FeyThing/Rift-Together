-- Adding Radiation to Cherry Forest.
local characters = {
    "whirlywings"
}

for i, prefab in ipairs(characters) do
    AddPrefabPostInit(prefab, function(inst)
        if not _G.TheWorld.ismastersim then
            return
        end

        inst.components.radiation:SetMax(TUNING.CHARACTERS_MAX_RADIATION[string.upper(prefab)])
    end)
end

AddPrefabPostInit("bismuthhat", function(inst)
    if not _G.TheWorld.ismastersim then
        return inst
    end	
    inst.components.equippable:SetRadiationProtectPercent(0.15)
end)

AddPrefabPostInit("bismuthshield", function(inst)	
    inst:AddTag("bismuthloaded")
end)


AddPrefabPostInit("armorbismuth", function(inst)
    if not _G.TheWorld.ismastersim then
        return inst
    end
    inst.components.equippable:SetRadiationProtectPercent(0.15)
end)

AddPrefabPostInit("cherry", function(inst)
    if not _G.TheWorld.ismastersim then
        return inst
    end
    inst.components.edible.radiationvalue = -1
end)	

    AddPrefabPostInit("cherry_cooked", function(inst)
    if not _G.TheWorld.ismastersim then
        return inst
    end
    inst.components.edible.radiationvalue = -2
end)

-- Immune
AddPrefabPostInit("cherry_daylily", function(inst)
    inst:AddTag("radiationimmunity")			
end)