local assets =
{
	Asset("ANIM", "anim/nanocrate.zip"),
}

local prefabs =
{
	"nanotech",
	"collapse_small",
}

SetSharedLootTable('nanocrate',
{
    {'nanotech',   1.00},

})

local function onhammered(inst)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function fn()
    --Carrot you eat is defined in veggies.lua
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddLight()

    inst.AnimState:SetBank("nanocrate")
    inst.AnimState:SetBuild("nanocrate")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:SetRayTestOnBB(true)
	
	inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetRadius(0.5)
    inst.Light:SetColour(0/255,255/255,255/255)
	inst.Light:Enable(true)

	inst:AddTag("light")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")
	
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('nanocrate')

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(onhammered)	
	
	
    MakeSmallPropagator(inst)

    return inst
end

return Prefab("nanocrate", fn, assets)



--- timeline 34, 67, 100, 134, 167, 200, 234, 267, 300, 334, 367, 400, 434, 467, 500, 534, 567