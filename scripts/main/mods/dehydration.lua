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