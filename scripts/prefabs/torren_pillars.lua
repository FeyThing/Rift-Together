local assets =
{
    Asset("ANIM", "anim/pillar_torrenivdesert.zip"),
    Asset("ANIM", "anim/pillar_torrenivdesert_small.zip"),
	Asset("ANIM", "anim/pillar_junk.zip"),
}

local function MakePillarJunk(name, bank, build, anim, loop)
    local assets = {
        Asset("ANIM", "anim/"..build..".zip"),
    }
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.entity:AddMiniMapEntity()
    
        MakeObstaclePhysics(inst, 2)
    
        inst.MiniMapEntity:SetIcon("pillar_junk.tex")
    
        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle", true)
    
        inst.entity:SetPristine()
    
        if not TheWorld.ismastersim then
            return inst
        end
    
        return inst
    end

    return Prefab(name, fn, assets)
end

local function MakePillarTall(name, bank, build, anim, loop)
    local assets = {
        Asset("ANIM", "anim/"..build..".zip"),
    }
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.entity:AddMiniMapEntity()
    
        MakeObstaclePhysics(inst, 2)
    
        inst.MiniMapEntity:SetIcon("pillar_torrenivdesert.tex")
    
        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle", true)
    
        inst.entity:SetPristine()
    
        if not TheWorld.ismastersim then
            return inst
        end
    
        return inst
    end

    return Prefab(name, fn, assets)
end

local function MakePillar(name, bank, build, anim, loop)
    local assets = {
        Asset("ANIM", "anim/"..build..".zip"),
    }
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.entity:AddMiniMapEntity()
    
        MakeObstaclePhysics(inst, 2.5)
    
        inst.MiniMapEntity:SetIcon("pillar_torrenivdesert.tex")
    
        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle", true)
    
        inst.entity:SetPristine()
    
        if not TheWorld.ismastersim then
            return inst
        end
    
        return inst
    end

    return Prefab(name, fn, assets)
end

return MakePillarTall("torrenivdesert_pillar", "pillar_torrenivdesert", "pillar_torrenivdesert", "idle", true),
    MakePillar("torrenivdesert_pillar_small", "pillar_torrenivdesert_small", "pillar_torrenivdesert_small", "idle", true),
    MakePillarJunk("junk_pillar", "pillar_junk", "pillar_junk", "idle", true)
