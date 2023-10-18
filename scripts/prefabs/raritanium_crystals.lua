local assets =
{
	Asset("ANIM", "anim/raritanium_crystals.zip"),
}

local prefabs =
{
    "rocks",
	"raritaniumore",
	"flint",
}    

SetSharedLootTable( 'raritanium_crystals',
{
    {'rocks',  1.00},
    {'raritaniumore',  1.00},
    {'flint',  0.20},
	{'raritaniumore',  0.10},
})

local MAXWORK = 10
local MEDIUM  = 6
local LOW     = 3

local function CurrentlyWorking(inst, worker, workleft)
    local pt = Point(inst.Transform:GetWorldPosition())
		if workleft <= 0 then
			inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
			inst.components.lootdropper:DropLoot(pt)
			inst:Remove()
    elseif workleft < TUNING.ROCKS_MINE / 3 then
        inst.AnimState:PlayAnimation("low")
    elseif workleft < TUNING.ROCKS_MINE * 2 / 3 then
        inst.AnimState:PlayAnimation("med")
    else
        inst.AnimState:PlayAnimation("full")
    end
end

local function prerock_fn(bank, build, anim, icon)
--entirely copied from rocks.lua
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	
	MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("raritanium_crystals.tex")

    inst.AnimState:SetBank(bank)
    inst.AnimState:SetBuild(build)
    inst.AnimState:PlayAnimation(anim)

    MakeSnowCoveredPristine(inst)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

	inst:AddComponent("lootdropper") 
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
	inst.components.workable:SetOnWorkCallback(CurrentlyWorking)

    local color = 0.5 + math.random() * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)

	inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "RARITANIUM_CRYSTALS"
	MakeSnowCovered(inst)

    MakeHauntableWork(inst)

	return inst
end


local function raritanium_crystals_fn()
	local inst = prerock_fn("raritanium_crystals", "raritanium_crystals", "full","raritanium_crystals.tex")

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.AnimState:SetBank("raritanium_crystals")
    inst.AnimState:SetBuild("raritanium_crystals")
    inst.AnimState:PlayAnimation("full")

	
	inst.components.lootdropper:SetChanceLootTable('raritanium_crystals')

	return inst
end


return Prefab( "forest/objects/raritanium_crystals", raritanium_crystals_fn, assets, prefabs)
