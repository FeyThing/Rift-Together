-- Adding Radiation and new boots to Shoetime.

AddPrefabPostInit("shoes_moonrock", function(inst)
       if not _G.TheWorld.ismastersim then
        return inst
    end
    inst.components.equippable:SetRadiationProtectPercent(0.15)
end)	
	
if _G.EQUIPSLOTS.SHOES then
	table.insert(PrefabFiles, "shoes_hover")
end