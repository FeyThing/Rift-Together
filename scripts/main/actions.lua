AddAction("RATCHET_DODGE" , _G.STRINGS.ACTIONS.DODGE_RATCHET , function(act, data)
    act.doer:PushEvent("ratchet_redirect_locomote", {pos = act.pos or _G.Vector3(act.target.Transform:GetWorldPosition())})
    return true
end)

_G.ACTIONS.RATCHET_DODGE.distance = math.huge
_G.ACTIONS.RATCHET_DODGE.instant = true

local EATSTR = _G.ACTIONS.EAT.stroverridefn
_G.ACTIONS.EAT.stroverridefn = function(act)
    if table.contains(_G.USE_DRINK_ANIM, act.invobject.prefab) then
        return _G.STRINGS.ACTIONS.DRINK
    end
    
    if EATSTR ~= nil then
        return EATSTR(act)
    end
end
