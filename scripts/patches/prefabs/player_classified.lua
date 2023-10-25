
local function OnRadiationDelta(parent, data)
    if data.overtime then

    elseif data.newpercent > data.oldpercent then
        SetDirty(parent.player_classified.isradiationpulseup, true)
    elseif data.newpercent < data.oldpercent then
        SetDirty(parent.player_classified.isradiationpulsedown, true)
    end
end

local function OnRadiationDirty(inst)
    if inst._parent ~= nil then
        local oldpercent = inst._oldradiationpercent
        local percent = inst.currentradiation:value() / inst.maxradiation:value()
        local data =
        {
            oldpercent = oldpercent,
            newpercent = percent,
            overtime =
                not (inst.isradiationpulseup:value() and percent > oldpercent) and
                not (inst.isradiationpulsedown:value() and percent < oldpercent),
        }
        inst._oldradiationpercent = percent
        inst.isradiationpulseup:set_local(false)
        inst.isradiationpulsedown:set_local(false)
        inst._parent:PushEvent("radiationdelta", data)
    else
        inst._oldradiationpercent = 1
        inst.isradiationpulseup:set_local(false)
        inst.isradiationpulsedown:set_local(false)
    end
end

local function RegisterNetListeners_mastersim(inst)
    inst:ListenForEvent("radiationdirtydelta", OnRadiationDelta, inst._parent)
end

local function RegisterNetListeners_local(inst)
    inst:ListenForEvent("radiationdirtydirty", OnRadiationDirty)
end

local function RegisterNetListeners(inst)
    if TheWorld.ismastersim then
        inst._parent = inst.entity:GetParent()
        RegisterNetListeners_mastersim(inst)
    else
        inst.isradiationpulseup:set_local(false)
        inst.isradiationpulsedown:set_local(false)
        RegisterNetListeners_local(inst)
    end

    --fns.OnInitialDirtyStates(inst)
end

return function(inst)
    inst._oldradiationpercent = 1
    inst.currentradiation = net_ushortint(inst.GUID, "radiation.current", "radiationdirty")
    inst.maxradiation = net_ushortint(inst.GUID, "radiation.max", "radiationdirty")
    inst.radiationpenalty = net_byte(inst.GUID, "radiation.penalty", "radiationdirty")
    inst.radiationratescale = net_tinybyte(inst.GUID, "radiation.ratescale")
    inst.isradiationpulseup = net_bool(inst.GUID, "radiation.dodeltaovertime(up)", "radiationdirty")
    inst.isradiationpulsedown = net_bool(inst.GUID, "radiation.dodeltaovertime(down)", "radiationdirty")
    inst.currentradiation:set(100)
    inst.maxradiation:set(100)

    inst:DoStaticTaskInTime(0, RegisterNetListeners)
    
    --CLIENT
    if not TheWorld.ismastersim then
        return
    end
    --SERVER
end