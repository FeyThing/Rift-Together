return function(self, inst)

local _ToggleCareful = self.ToggleCareful
function self:ToggleCareful(...)
    if self.inst:HasTag("hovershoed") then 
        return false
    end		
    return _ToggleCareful(self, ...)
	end
			
end