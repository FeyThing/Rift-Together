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



-- Smelt
local VULLARD_SMELT = AddAction("VULLARD_SMELT", _G.STRINGS.ACTIONS.VULLARD_SMELT, function(act)
	if act.target ~= nil and act.target.components.vullard_smelter ~= nil then
		if act.target.components.vullard_smelter:IsSmelting() then
			return true
		end
		
		local container = act.target.components.container
		if container ~= nil and container:IsOpenedByOthers(act.doer) then
			return false, "INUSE"
		elseif not act.target.components.vullard_smelter:CanSmelt() then
			return false
		end
		
		act.target.components.vullard_smelter:StartSmelting(act.doer)
		return true
	end
end)

AddStategraphActionHandler("wilson", _G.ActionHandler(VULLARD_SMELT, "dolongaction"))
AddStategraphActionHandler("wilson_client", _G.ActionHandler(VULLARD_SMELT, "dolongaction"))

AddComponentAction("SCENE", "vullard_smelter", function(inst, doer, actions, right)
	if right and inst:HasTag("readytosmelt") then
		table.insert(actions, VULLARD_SMELT)
	end
end)