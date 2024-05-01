--local TOOL_TAGS = {"tool", "weapon"}
--local TOOL_NOT_TAGS = {"raritanium", "reinforced", "shadow_item", "icebox_valid", "bismuthloaded", "show_broken_ui", "guitar"}


local function DamageTools(inst, data)

	local weapon = data and data.weapon
    if weapon and weapon.components.finiteuses then
	if not weapon:HasTag("raritanium") or  
	weapon:HasTag("reinforced") or 
	weapon:HasTag("shadow_item") or 
	weapon:HasTag("icebox_valid") or 
	weapon:HasTag("bismuthloaded") or 
	weapon:HasTag("show_broken_ui") or 
	weapon:HasTag("guitar") then
	print ("weapon has been found, eat durability and trigger sound")
        weapon.components.finiteuses:Use(3)
        inst.SoundEmitter:PlaySound("dontstarve/wilson/use_break", nil, nil, true)
		SpawnPrefab("brokentool").Transform:SetPosition(inst.Transform:GetWorldPosition())
		--inst.components.health.absorb = .5
    end	
	end	
end

local Armoredbody = Class(function(self, inst)
    self.inst = inst
    
    self.DamageTools = DamageTools
    	
	inst:ListenForEvent("attacked", self.DamageTools)
end)

return Armoredbody


