local function FindInRadius(inst, radius, amount, clear)
	local half = radius * TILE_SCALE
	local x1,y1,z1 = inst.Transform:GetWorldPosition()
	local pos = Vector3(TheWorld.Map:GetTileCenterPoint(x1,y1,z1))
	local pos = Vector3(TheWorld.Map:GetTileCenterPoint(x1,y1,z1))
	local distmax =  inst:GetDistanceSqToPoint(pos.x+half,pos.y,pos.z+half)
	for x = -half, half, TILE_SCALE do
		for z = -half, half, TILE_SCALE do
			local distsq = inst:GetDistanceSqToPoint(pos.x+x,pos.y,pos.z+z)
			if not clear then
				TheWorld.components.radiation_manager:AddRadiationAtPoint(pos.x+x,pos.y,pos.z+z, amount*(math.max((0.75-distsq/distmax), 0)))
			else
				TheWorld.components.radiation_manager:RemoveRadiationAtPoint(pos.x+x,pos.y,pos.z+z, amount*(math.max((0.75-distsq/distmax), 0)))
			end
		end
	end
end

local RadiationSpreader = Class(function(self, inst)
    self.inst = inst
    self.radius = 5
    self.amount = 10

	self.isspreading = false

	self.inst:DoTaskInTime(0, function() self:StartSpreading() end)
end)

function RadiationSpreader:OnRemoveFromEntity()
	self:StopSpreading()
end

function RadiationSpreader:SetRadius(radius)
	self.radius = radius
end

function RadiationSpreader:SetAmount(amount)
	self.amount = amount
end

function RadiationSpreader:StartSpreading()
	if not self.isspreading then
		self.isspreading = true
		FindInRadius(self.inst, self.radius, self.amount)
	end
end

function RadiationSpreader:StopSpreading()
	self.isspreading = false
	FindInRadius(self.inst, self.radius, self.amount, true)
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
