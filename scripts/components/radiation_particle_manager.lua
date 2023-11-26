local Radiation = Class(function(self, inst)
    self.inst = inst

    self.update_values = net_string(self.inst.GUID, "inst.updateparticles", "updateparticles")
	inst:ListenForEvent("updateparticles", function() self:UpdateData()	end)
	local w, h = TheWorld.Map:GetSize()
	self._radiationgrid = DataGrid(w, h)
end)

function Radiation:GetIndex(x, y)
	return y * self._radiationgrid.width + x
end

function Radiation:UpdateData()
    local data = loadstring(self.update_values:value())()
	self._radiationgrid = data
end

function Radiation:GetRadiationAtPoint(x, y, z)
	local radiation = self._radiationgrid.grid[self:GetIndex(TheWorld.Map:GetTileCoordsAtPoint(x, y, z))]
	return radiation or 0
end
return Radiation