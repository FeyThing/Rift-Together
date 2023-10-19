AddAction("RATCHET_DODGE" , STRINGS.ACTIONS.DODGE_RATCHET , function(act, data)
    act.doer:PushEvent("ratchet_redirect_locomote", {pos = act.pos or Vector3(act.target.Transform:GetWorldPosition())})
    return true
end)

ACTIONS.RATCHET_DODGE.distance = math.huge
ACTIONS.RATCHET_DODGE.instant = true
