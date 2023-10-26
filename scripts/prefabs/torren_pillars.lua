local function MakePillar(name, bank, build, anim, loop, height, minimap)
    local assets = {
        Asset("ANIM", "anim/"..build..".zip"),
    }
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.entity:AddMiniMapEntity()
    
        MakeObstaclePhysics(inst, height or 2)
    
        inst.MiniMapEntity:SetIcon(minimap..".tex")
    
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

return MakePillar("torrenivdesert_pillar", "pillar_torrenivdesert", "pillar_torrenivdesert", "idle", true, 2, "pillar_torrenivdesert"),
    MakePillar("torrenivdesert_pillar_small", "pillar_torrenivdesert_small", "pillar_torrenivdesert_small", "idle", true, 2.5, "pillar_torrenivdesert"),
    MakePillar("junk_pillar", "pillar_junk", "pillar_junk", "idle", true, 2, "pillar_junk")
