local function onsciondeath(inst, data)
local x, y, z = inst.Transform:GetWorldPosition()
    if data.afflicter == inst 
		and data.inst:HasTag("chess") 
		and data.inst:HasTag("monster") then	
		    local fx = SpawnPrefab("small_puff")
	        fx.Transform:SetPosition(x + 1, y, z)
	        fx.Transform:SetScale(1.5, 1.5, 1.5)		 			
        if data.inst:HasTag("knight") then        
            local scion1 = SpawnPrefab("chessjunk5")
            scion1.Transform:SetPosition(x + 1, y, z)
               	   			
        elseif data.inst:HasTag("bishop") then        
            local scion1 = SpawnPrefab("chessjunk4")
            scion1.Transform:SetPosition(x + 1, y, z)
					
		elseif data.inst:HasTag("rook") then      
            local scion1 = SpawnPrefab("chessjunk6")
            scion1.Transform:SetPosition(x + 1, y, z)			
		end
  
	end
end
	


return onsciondeath