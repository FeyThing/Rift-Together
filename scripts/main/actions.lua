AddAction("RATCHET_DODGE" , STRINGS.ACTIONS.DODGE_RATCHET , function(act, data)
    act.doer:PushEvent("ratchet_redirect_locomote", {pos = act.pos or Vector3(act.target.Transform:GetWorldPosition())})
    return true
end)

ACTIONS.RATCHET_DODGE.distance = math.huge
ACTIONS.RATCHET_DODGE.instant = true

local EATSTR = ACTIONS.EAT.stroverridefn
ACTIONS.EAT.stroverridefn = function(act)
    if table.contains(GLOBAL.USE_DRINK_ANIM, act.invobject.prefab) then
        return STRINGS.ACTIONS.DRINK
    end
    
    if EATSTR ~= nil then
        return EATSTR(act)
    end
end
