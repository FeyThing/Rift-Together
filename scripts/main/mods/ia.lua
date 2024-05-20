--- Setting radiation value for IA characters
local characters = {
    "walani",
    "wilbur",
    "woodlegs"
}

for i, prefab in ipairs(characters) do
    AddPrefabPostInit(prefab, function(inst)
        if not _G.TheWorld.ismastersim then
            return
        end

        inst.components.radiation:SetMax(TUNING.CHARACTERS_MAX_RADIATION[string.upper(prefab)])
    end)
end

-- Adding Radiation to Island Adventures.
AddPrefabPostInit("bananapop", function(inst)
    if not _G.TheWorld.ismastersim then
        return inst
    end

    inst.components.edible.radiationvalue = 5
end)	

-- Rift Together Luminous tree compatibility
TUNING.LUMINOUS_WINDBLOWN_SPEED = 0.2
TUNING.LUMINOUS_WINDBLOWN_FALL_CHANCE = 0

AddPrefabPostInit("luminoustree", function(inst)
    inst:AddTag("gustable")
    
    if not _G.TheWorld.ismastersim then
        return inst
    end
    
    _G.MakeTreeBlowInWindGust(inst, TUNING.LUMINOUS_WINDBLOWN_SPEED, TUNING.LUMINOUS_WINDBLOWN_FALL_CHANCE)
end)