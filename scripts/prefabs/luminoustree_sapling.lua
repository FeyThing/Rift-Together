local assets =
{
    Asset("ANIM", "anim/luminous_fruit.zip"),
}

local prefabs =
{
    "luminoustree",
}

local function growtree(inst)
    local tree = SpawnPrefab(inst.growprefab)
    if tree then
        tree.Transform:SetPosition(inst.Transform:GetWorldPosition())
        tree:growfromseed()
        inst:Remove()
    end
end

local function stopgrowing(inst)
    inst.components.timer:StopTimer("grow")
end

startgrowing = function(inst)
    if not inst.components.timer:TimerExists("grow") then
        local growtime = GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
        inst.components.timer:StartTimer("grow", growtime)
    end
end

local function ontimerdone(inst, data)
    if data.name == "grow" then
        growtree(inst)
    end
end

local function digup(inst, digger)
    inst.components.lootdropper:DropLoot()
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    inst.AnimState:SetBank("luminous_fruit")
    inst.AnimState:SetBuild("luminous_fruit")
    inst.AnimState:PlayAnimation("idle_planted")
    
    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end
    
    inst.growprefab = "luminoustree"
    inst.StartGrowing = startgrowing
    
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", ontimerdone)
    startgrowing(inst)
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"twigs"})
    
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(digup)
    inst.components.workable:SetWorkLeft(1)
    
    inst:ListenForEvent("onignite", stopgrowing)
    inst:ListenForEvent("onextinguish", startgrowing)
    
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    MakeHauntableIgnite(inst)
    
    return inst
end

return Prefab("luminoustree_sapling", fn, assets, prefabs)