local assets = {
    Asset("ANIM", "anim/radioactive_barrel.zip"),
    --Asset("MINIMAP_IMAGE", "barrel_radioactive")
}

local prefabs = {
    "collapse_small",
}

local function onhammered(inst)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end


local function MakeBarrel(name)
    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
        inst.entity:AddMiniMapEntity()
		inst.entity:AddLight()

        --inst.MiniMapEntity:SetIcon("barrel_radioactive.tex")

        MakeWaterObstaclePhysics(inst, 0.80, 2, 0.75)

        MakeInventoryFloatable(inst, "med", nil, 0.85)

        inst.Light:SetFalloff(0.7)
		inst.Light:SetIntensity(1)
		inst.Light:SetRadius(0.5)
		inst.Light:SetColour(25/255,255/255,100/255)
		inst.Light:Enable(false)

        inst.AnimState:SetBank("radioactive_barrel")
        inst.AnimState:SetBuild("radioactive_barrel")

        inst.AnimState:PlayAnimation("idle", true)
        
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        local land_time = (POPULATING and math.random()*5*FRAMES) or 0
        inst:DoTaskInTime(land_time, function(inst)
            inst.components.floater:OnLandedServer()
        end)

        inst:AddComponent("inspectable")
        
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
		inst.components.workable:SetWorkLeft(5)
		inst.components.workable:SetOnFinishCallback(onhammered)

		inst:AddComponent("radiationspreader")
        inst.components.radiationspreader:SetRadius(2)

        inst:ListenForEvent("floater_startfloating", function(inst) inst.AnimState:PlayAnimation("idle_water", true) end)

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
		
end

return MakeBarrel("barrel_radioactive")
