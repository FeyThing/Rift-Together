local function MakeAlloy(name, anim, common_postinit, master_postinit)
	local assets = {
		Asset("ANIM", "anim/rt_alloys.zip"),
	}
	
	local function fn()
		local inst = CreateEntity()
		
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()
		
		MakeInventoryPhysics(inst)
		
		inst.AnimState:SetBuild("rt_alloys")
		inst.AnimState:SetBank("rt_alloys")
		inst.AnimState:PlayAnimation(anim)
		
		inst:AddTag("alloy")
		
		if common_postinit ~= nil then
			common_postinit(inst)
		end
		
		inst.entity:SetPristine()
		
		if not TheWorld.ismastersim then
			return inst
		end
		
		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM
		
		inst:AddComponent("tradable")
		
		inst:AddComponent("inspectable")
		
		inst:AddComponent("inventoryitem")
		
		MakeHauntableLaunch(inst)
		
		if master_postinit ~= nil then
			master_postinit(inst)
		end
		
		return inst
	end
	
	return Prefab(name, fn, assets)
end

local function OnRepaired(inst, target, doer)
	doer:PushEvent("repair")
end

local function raritanium_master_postinit(inst)
	inst:AddComponent("forgerepair")
	inst.components.forgerepair:SetRepairMaterial(FORGEMATERIALS.RARITANIUM_BAR)
	inst.components.forgerepair:SetOnRepaired(OnRepaired)
end

return MakeAlloy("raritanium_bar", "idle_raritanium", nil, raritanium_master_postinit),
	   MakeAlloy("gold_bar", "idle_gold"),
	   MakeAlloy("scrap_bar", "idle_scrap"),
	   MakeAlloy("moonglass_bar", "idle_moonglass")




