local TOOL_TAGS = {"tool", "weapon"}
local TOOL_NOT_TAGS = {"raritanium", "reinforced", "shadow_item", "icebox_valid", "bismuthloaded", "show_broken_ui", "guitar"}

local function DamageTools(inst, attacker)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 12, nil, TOOL_NOT_TAGS, TOOL_TAGS)
    
    for i, v in ipairs(ents) do
        if v.components.finiteuses then
            v.components.finiteuses:Use(3)
			--if ents:HasTag("player") then
                        --v.sg:GoToState("toolbroke")
                   -- end
			
			--SpawnPrefab("brokentool").Transform:SetPosition(inst.Transform:GetWorldPosition())
			--inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter", nil, nil, true)
        end		
		--[[if v.components.combat ~= nil then
			if attacker ~= nil  then
			inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter", nil, nil, true)
			SpawnPrefab("brokentool").Transform:SetPosition(inst.Transform:GetWorldPosition())
			end
		end]]
	end
	
end

local Armoredbody = Class(function(self, inst)
    self.inst = inst
    
    self.DamageTools = DamageTools
    
    --self.damagetask = self.inst:DoPeriodicTask(1, self.DamageTools)
	
	inst:ListenForEvent("attacked", self.DamageTools)
end)

return Armoredbody


