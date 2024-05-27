local assets =
{
    Asset("ANIM", "anim/scrapbase.zip"),
}

local prefabs =
{
    "goldnugget",
    "scrapbits",
    "collapse_small",
}

local names = { "piece1", "piece2", "piece3" }

SetSharedLootTable('scrapmetal',
{
    {'goldnugget',  .5},
})

local function onsave(inst, data)
    data.anim = inst.animname
end

local function onload(inst, data)
    if data ~= nil and data.anim ~= nil then
        inst.animname = data.anim
        inst.AnimState:PlayAnimation(inst.animname)
    end
end

local function onhammered(inst, worker)

	if inst.components.childspawner ~= nil then
        inst.components.childspawner:ReleaseAllChildren()
    end

    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("scrapbase")
    inst.AnimState:SetBank("scrapbase")

    inst:AddTag("chess")

    --MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    local scraptype = math.random(#names)
    inst.animname = names[scraptype]
    inst.AnimState:PlayAnimation(inst.animname)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(onhammered)


    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('scrapmetal')
    if scraptype == 3 then
        inst.components.lootdropper:AddChanceLoot("scrapbits", .3)
    end

    MakeHauntableLaunch(inst)

    -------------------
    inst:AddComponent("inspectable")

    MakeSnowCovered(inst)
	
    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("scrapmetal", fn, assets, prefabs)
