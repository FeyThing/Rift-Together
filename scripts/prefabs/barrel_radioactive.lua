local assets = {
    Asset("ANIM", "anim/radioactive_barrel.zip"),
    --Asset("MINIMAP_IMAGE", "barrel_radioactive")
}

local prefabs = {
    "collapse_small",
}

local function onhammered(inst)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function MakeBarrel(name, land)
    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
        inst.entity:AddMiniMapEntity()
		inst.entity:AddLight()

        --inst.MiniMapEntity:SetIcon("barrel_radioactive.tex")

        MakeObstaclePhysics(inst, 0.5)


		inst.Light:SetFalloff(0.7)
		inst.Light:SetIntensity(1)
		inst.Light:SetRadius(0.5)
		inst.Light:SetColour(25/255,255/255,100/255)
		inst.Light:Enable(false)

        inst.AnimState:SetBank("radioactive_barrel")
        inst.AnimState:SetBuild("radioactive_barrel")

        inst.AnimState:PlayAnimation(land and "idle" or "idle_water", true)
        
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")
        
       if land then
            inst.components.inspectable.nameoverride = "barrel_radioactive"
        end

		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
		inst.components.workable:SetWorkLeft(5)
		inst.components.workable:SetOnFinishCallback(onhammered)

		inst:AddComponent("radiationspreader")
		

   
        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return MakeBarrel("barrel_radioactive"),
       MakeBarrel("barrel_radioactive_land", true)
