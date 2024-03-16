return function(inst, owner)
		
	    if not TheWorld.ismastersim then

        return inst
        end

        local OldEquip = inst.components.equippable.onequipfn			
            inst.components.equippable.onequipfn = function(inst, owner, symbol_override)
			OldEquip(inst, owner, symbol_override)
            if owner:HasTag("veldin_mechanic") then
                owner.AnimState:Hide("HAIRFRONT")
                owner.AnimState:Hide("HAIR")
                --owner.AnimState:Hide("HAIR_NOHAT")
                owner.AnimState:Hide("HEAD_HAT")
                owner.AnimState:Hide("HAIR_HAT")
                owner.AnimState:Show("HEAD")
            end           
        end
        
        local OldUnequip = inst.components.equippable.onunequipfn
        inst.components.equippable.onunequipfn = function(inst, owner)
            if (owner:HasTag("veldin_mechanic")) then
                owner.AnimState:Show("HAIRFRONT")
                owner.AnimState:Show("HAIR")
                --owner.AnimState:Show("HAIR_NOHAT")
            end
            OldUnequip(inst, owner)
        end
	
	--[[if owner ~= nil and owner.instab == "ratchet" then	
		
	end	]]
	
end