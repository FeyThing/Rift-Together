local function OnFueled(inst)
    local installed = inst.components.container ~= nil and inst:HasTag("weaponmod")

    if installed ~= nil and inst.components.fueled ~= nil then	
        inst.components.fueled:StartConsuming()
    end
end

local function CreateMod(name, bank, build, anim, fuellevel)
    local assets = {
        Asset("ANIM", "anim/"..byukd..".zip"),
    }
    local prefabs = {}
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBuild(bank)
        inst.AnimState:SetBank(build)
        inst.AnimState:PlayAnimation(anim)

        inst:AddTag("rnc_mod")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("fueled")
        inst.components.fueled.fueltype = FUELTYPE.USAGE
        inst.components.fueled:InitializeFuelLevel(fuellevel)
        inst.components.fueled:SetDepletedFn(inst.Remove)

        OnFueled(inst)

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "images/rnc_inventoryimages.xml"

        MakeHauntableLaunch(inst)

        return inst
    end
    return Prefab(name, fn, assets)
end

return CreateMod("cryomod", "cryomod", "cryomod", "idle", TUNING.SWEATERVEST_PERISHTIME),
        CreateMod("napalmmod", "napalmmod", "napalmmod", "idle", TUNING.SWEATERVEST_PERISHTIME),
        CreateMod("shockmod", "shockmod", "shockmod", "idle", TUNING.SWEATERVEST_PERISHTIME)