-- Adding Radiation and new boots to Shoetime.

AddPrefabPostInit("shoes_moonrock", function(inst)
       if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    inst.components.equippable:SetRadiationProtectPercent(0.15)
end)	
	
