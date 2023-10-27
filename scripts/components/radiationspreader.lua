local function FindInRadius(inst, radius, clear)
	local half = radius * TILE_SCALE * 0.5
	local x1,y1,z1 = inst.Transform:GetWorldPosition()
	local pos = Vector3(TheWorld.Map:GetTileCenterPoint(x1,y1,z1))
	for x = -half, half, TILE_SCALE do
		for z = -half, half, TILE_SCALE do
			local distsq = inst:GetDistanceSqToPoint(pos.x+x,pos.y,pos.z+z)
			if distsq < (half + half)*2  then
				if not clear then
					TheWorld.components.radiation_manager:AddRadiationAtPoint(pos.x+x,pos.y,pos.z+z, amount*(1-distsq/((half + half)*2)))
				else
					TheWorld.components.radiation_manager:RemoveRadiationAtPoint(pos.x+x,pos.y,pos.z+z, amount*(1-distsq/((half + half)*2)))
				end
			end
		end
	end
end

local RadiationSpreader = Class(function(self, inst)
    self.inst = inst
    self.radius = 4
    self.amount = 5
end)

function RadiationSpreader:OnRemoveFromEntity()
	if not TheWorld or not TheWorld.components.radiation_manager then
		return
	end
	self:StopSpreading()
end

function RadiationSpreader:SetRadius(radius)
	self.radius = radius
end

function RadiationSpreader:SetAmount(amount)
	self.amount = amount
end

function RadiationSpreader:StartSpreading()
	FindInRadius(inst, self.radius)
end

function RadiationSpreader:StopSpreading()
	FindInRadius(inst, self.radius, true)
end

function RadiationSpreader:OnSave()
    return
    {
        radius = self.radius,
        amount = self.amount,
    }
end

function RadiationSpreader:OnLoad(data)
    if data then
        self.radius = data.radius
        self.amount = data.amount
    end
end


return RadiationSpreader
