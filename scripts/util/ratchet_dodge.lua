local Vector3 = GLOBAL.Vector3
local ACTIONS = GLOBAL.ACTIONS
local ActionHandler = GLOBAL.ActionHandler
local id = "RATCHET_DODGE" 
local name = STRINGS.RATCHETSTRINGS[3] 
AddAction(id, name, function(act, data)
	--local inst = act.doer
    act.doer:PushEvent("ratchet_redirect_locomote", {pos = act.pos or GLOBAL.Vector3(act.target.Transform:GetWorldPosition())})
    return true
end)

ACTIONS.RATCHET_DODGE.distance = math.huge
ACTIONS.RATCHET_DODGE.instant = true
