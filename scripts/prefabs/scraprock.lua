require("worldsettingsutil")

local assets =
{
    Asset("ANIM", "anim/scrapbase.zip"),
    Asset("SOUND", "sound/hound.fsb"),
	Asset("MINIMAP_IMAGE", "scrap_mound"),
}

local prefabs =
{
    "hound_robomutt",
    "raritaniumore",
    "trinket_6",
}

SetSharedLootTable('scrap_mound',
{
    {'goldnugget', 0.33},
    {'trinket_6', 0.5},
    {'raritaniumore',   1.00},
    {'cutgrass',      0.6},
    {'gears',     0.01},
    {'rarisword_blueprint',     0.1},
    {'cryomod_blueprint',     0.2},
    {'napalmod_blueprint',     0.2},
    {'shockmod_blueprint',     0.2},
})

local function onhammered(inst)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:ReleaseAllChildren()
    end
    inst.AnimState:PlayAnimation("death", false)
	
	local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
    inst.SoundEmitter:KillSound("loop")
    inst.components.lootdropper:DropLoot(inst:GetPosition())
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .5)

    inst.MiniMapEntity:SetIcon("scrap_mound.tex")

    inst.AnimState:SetBank("scrapbase")
    inst.AnimState:SetBuild("scrapbase")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("structure")
    inst:AddTag("scraprock")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('scrap_mound')

    ---------------------
    inst:AddComponent("inspectable")

    MakeSnowCovered(inst)

    return inst
end

return Prefab("scraprock", fn, assets, prefabs)
