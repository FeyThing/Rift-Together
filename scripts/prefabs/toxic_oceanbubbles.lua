local anims = {
    {
        bank = "Bubble_fx",
        build = "crab_king_bubble_fx",
        anim = {"bubbles_1", "bubbles_2", "bubbles_3"},
        chance = 0.2,
        mult = {.3, .75, .5, 1},
    },
    {
        bank = "crater_steam",
        build = "crater_steam",
        anim = {"steam1", "steam2", "steam3", "steam4"},
        chance = 0.2,
        mult = {.3, .75, .5, 1},
    },
    {
        bank = "slow_steam",
        build = "slow_steam",
        anim = {"steam1", "steam2", "steam3", "steam4", "steam5"},
        chance = 0.2,
        mult = {.3, .75, .5, 1},
    },
    {
        bank = "quagmire_portalspawn_fx",
        build = "quagmire_portalspawn_fx",
        anim = "idle",
        chance = 0.2,
        hue = {0.85, 0.9}
    }
}
local function startfx(proxy)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.Transform:SetFromProxy(proxy.GUID)

    local data = anims[math.random(#anims)]
    inst.AnimState:SetBank(data.bank)
    inst.AnimState:SetBuild(data.build)
    inst.AnimState:PlayAnimation(type(data.anim) == "table" and data.anim[math.random(#data.anim)] or data.anim) 
    if data.hue then
        inst.AnimState:SetHue(math.random(data.hue[1], data.hue[2]))
    end
    if data.mult then
        inst.AnimState:SetMultColour(unpack(data.mult))
    end
    inst:ListenForEvent("animover", inst.Remove)
end 

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    if not TheNet:IsDedicated() then
        inst:DoTaskInTime(0, startfx, inst)
    end

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst:DoTaskInTime(1, inst.Remove)

    return inst
end

return Prefab("toxic_oceanbubbles", fn)