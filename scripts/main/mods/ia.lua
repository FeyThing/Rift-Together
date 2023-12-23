--- Setting radiation value for IA characters
local characters = {
    WALANI = 100,
    WILBER = 100,
    WOODLEGS = 150
}

for k, v in pairs(characters) do
    AddPrefabPostInit(v, function(inst)
        inst.components.radiation:SetMax(TUNING.CHARACTERS_RADIATION.characters)
    end)
end

-- Adding Radiation to Island Adventures.
AddPrefabPostInit("bananapop", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    inst.components.edible.radiationvalue = 5
end)	

-- Rift Together Luminous tree compatibility
TUNING.LUMINOUS_WINDBLOWN_SPEED = 0.2
TUNING.LUMINOUS_WINDBLOWN_FALL_CHANCE = 0

AddPrefabPostInit("luminoustree", function(inst)
    inst:AddTag("gustable")
    
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    
    GLOBAL.MakeTreeBlowInWindGust(inst, TUNING.LUMINOUS_WINDBLOWN_SPEED, TUNING.LUMINOUS_WINDBLOWN_FALL_CHANCE)
end)