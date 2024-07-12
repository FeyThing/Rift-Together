-- Forces a netvar to be dirty regardless of value
local function SetDirty(netvar, val)
    netvar:set_local(val)
    netvar:set(val)
end

local function OnRadiationDelta(parent, data)
    if data.overtime then
        -- V2C: Don't clear: it's redundant as player_classified shouldn't
        --      get constructed remotely more than once, and this would've
        --      also resulted in lost pulses if network hasn't ticked yet.
        -- parent.player_classified.isradiationpulseup:set_local(false)
        -- parent.player_classified.isradiationpulsedown:set_local(false)
    elseif data.newpercent > data.oldpercent then
        SetDirty(parent.player_classified.isradiationpulseup, true)
    elseif data.newpercent < data.oldpercent then
        SetDirty(parent.player_classified.isradiationpulsedown, true)
    end
end

local function OnRadiationDirty(inst)
    local oldpercent = inst._oldradiationpercent
    local percent = inst.currentradiation:value() / inst.maxradiation:value()
    local data = {
        oldpercent = oldpercent,
        newpercent = percent,
        overtime = not (inst.isradiationpulseup:value() and percent > oldpercent) and
                   not (inst.isradiationpulsedown:value() and percent < oldpercent)
    }
    
    inst._oldradiationpercent = percent
    inst.isradiationpulseup:set_local(false)
    inst.isradiationpulsedown:set_local(false)
    inst._parent:PushEvent("radiationdelta", data)
end

local function RegisterNetListeners_mastersim(inst, parent)
    if parent then
        inst:ListenForEvent("radiationdelta", OnRadiationDelta, parent)
    end
end

local function RegisterNetListeners_local(inst)
    inst:ListenForEvent("radiationdirty", OnRadiationDirty)
end

local function OnInitialDirtyStates(inst)
    if not TheWorld.ismastersim then
        inst._oldradiationpercent = inst.maxradiation:value() > 0 and inst.currentradiation:value() / inst.maxradiation:value() or 0
    end
end

local function FinishSeamlessPlayerSwap(parent)
    local inst = parent.player_classified
    inst:RemoveEventCallback("finishseamlessplayerswap", FinishSeamlessPlayerSwap, parent)
    OnInitialDirtyStates(inst)
end

local function RegisterNetListeners(inst)
    local _parent = inst.entity:GetParent() -- In case the original RegisterNetListeners runs after this one

    if _G.TheWorld.ismastersim then
        RegisterNetListeners_mastersim(inst, _parent)
    else
        inst.isradiationpulseup:set_local(false)
        inst.isradiationpulsedown:set_local(false)
        RegisterNetListeners_local(inst)
    end

    OnInitialDirtyStates(inst)

    if _parent and _parent.isseamlessswaptarget then
        -- finishseamlessplayerswap will be able to retrigger all the instant events if the initialization happened in the "wrong" order.
        inst:ListenForEvent("finishseamlessplayerswap", FinishSeamlessPlayerSwap, inst._parent)
    end
end

local function OverrideOnEntityReplicated(inst)
    local old_OnEntityReplicated = inst.OnEntityReplicated
    inst.OnEntityReplicated = function(inst, ...)
        old_OnEntityReplicated(inst, ...)
        inst._parent = inst.entity:GetParent()
        if inst._parent and inst._parent.replica.radiation then
            inst._parent.replica.radiation:AttachClassified(inst)
        end
    end
end

return function(inst)
    -- CLIENT & SERVER
    -- Radiation variables
    inst._oldradiationpercent = 1
    inst.currentradiation = net_ushortint(inst.GUID, "radiation.current", "radiationdirty")
    inst.maxradiation = net_ushortint(inst.GUID, "radiation.max", "radiationdirty")
    inst.radiationpenalty = net_byte(inst.GUID, "radiation.penalty", "radiationdirty")
    inst.radiationratescale = net_tinybyte(inst.GUID, "radiation.ratescale")
    inst.isradiationpulseup = net_bool(inst.GUID, "radiation.dodeltaovertime(up)", "radiationdirty")
    inst.isradiationpulsedown = net_bool(inst.GUID, "radiation.dodeltaovertime(down)", "radiationdirty")
    inst.radiationstate = net_tinybyte(inst.GUID, "radiation.state")
    inst.currentradiation:set(100)
    inst.maxradiation:set(100)

    inst:DoStaticTaskInTime(0, RegisterNetListeners)

    if not _G.TheWorld.ismastersim then
        OverrideOnEntityReplicated(inst)

        return
    end
    -- SERVER
end