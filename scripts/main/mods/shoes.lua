-- Adding Radiation to Shoes.

AddPrefabPostInit("shoes_moonrock", function(inst)
       if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    inst.components.equippable:SetRadiationProtectPercent(0.15)
end)	
	
if GLOBAL.EQUIPSLOTS.SHOES then
	table.insert(PrefabFiles, "shoes_hover")
end