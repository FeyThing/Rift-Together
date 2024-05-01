local prefabs =
{
	"rt_pawn",
	"rt_pawn_nightmare",
}


SetSharedLootTable("chess_junk_less",
{
    {'trinket_6',      0.60},   
})

local function SetLessLoot(inst)
    inst.lessloot = true

    inst.components.lootdropper.randomloot = {}
    inst.components.lootdropper.totalrandomweight = 0
    inst.components.lootdropper:SetChanceLootTable("chess_junk_less")
end

return function(inst)
    --CLIENT
    if not TheWorld.ismastersim then
        return
    end
    --SERVER
	
	-------
	inst:AddComponent("childspawner")
    if TheWorld:HasTag("cave") then
        inst.components.childspawner.childname = "rt_pawn_nightmare"
    else        
		inst.components.childspawner.childname = "rt_pawn"
    end

    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 2)
	inst.components.childspawner:SetSpawnPeriod(TUNING.CATCOONDEN_RELEASE_TIME)
    inst.components.childspawner:SetSpawnPeriod(1)
    inst.components.childspawner:SetMaxChildren(1)
	inst.components.childspawner.spawnoffscreen = true
	inst.components.childspawner:StartSpawning()

	-------
	
	inst.SetLessLoot = SetLessLoot

    local _OnSave = inst.OnSave
    inst.OnSave = function(inst, data)
        data.lessloot = inst.lessloot
        return _OnSave(inst, data)
    end
    local _OnLoad = inst.OnLoad
    inst.OnLoad = function(inst, data)
        if data and data.lessloot then
            inst:SetLessLoot()
        end
        return _OnLoad(inst, data)
    end
end
