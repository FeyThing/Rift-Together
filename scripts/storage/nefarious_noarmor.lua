
local function noarmor(inst)

local _Equip = inst.components.inventory.Equip	

inst.components.inventory.Equip = function(self, item, old_to_active)
	if not item or not item.components.equippable or not item:IsValid() then
		return		
	end		
	
	if item.components.equippable.equipslot == EQUIPSLOTS.HEAD and not (item.prefab == "ruinshat") and not (item.prefab == "flowerhat") and not (item.prefab == "eyebrellahat") and not (item.prefab == "kelphat") 
	or item.components.equippable.equipslot == EQUIPSLOTS.BODY and item.components.armor then		
		self:DropItem(item)
		self:GiveItem(item)
		if inst and inst.components.talker then
			inst.components.talker:Say("Bah, does it look like that fits me?")
		end
		return
	end		
	return _Equip(self, item, old_to_active)

	
end
	
end

	


return noarmor

