local function ContaminateTiles(inst)
    local radiationsource = inst.components.radiationsource
    local radius = radiationsource.radius
    local amount = radiationsource.contamination_amount
    local x, y, z = inst.Transform:GetWorldPosition()

    local checking_period = radius/math.ceil(radius/TILE_SCALE) -- LukaS: Special interval to always reach 'radius' when starting from '-radius'
    local checked_tiles = {  } -- This can result in checking the same tile twice so remember those we already checked
    for x2 = -radius, radius, checking_period do
        for z2 = -radius, radius, checking_period do
            local tile_x, tile_y = TheWorld.Map:GetTileCoordsAtPoint(x + x2, y, z + z2)
            local index = TheWorld.components.radiationmanager:GetGrid():GetIndex(tile_x, tile_y)
            
            if checked_tiles[index] == nil then
                checked_tiles[index] = true

                local target_x, target_y, target_z = TheWorld.Map:GetTileCenterPoint(tile_x, tile_y)
                local distsq = inst:GetDistanceSqToPoint(target_x, target_y, target_z)
                local radiussq = radius*radius
                if distsq <= radiussq then
                    local factor = 1 - (distsq/radiussq)
                    local radiation = TheWorld.components.radiationmanager:GetAtPoint(target_x, target_y, target_z)
                    if factor > radiation/TUNING.MAX_TILE_RAD then -- Max radiation per tile is determined by how close the tile is to a source
                        TheWorld.components.radiationmanager:DoDeltaAtTile(tile_x, tile_y, amount*factor)
                    end
                end
            end
        end
    end
end

local RadiationSource = Class(function(self, inst)
    self.inst = inst

    self.radius = 4 -- 4 == 1 tile
    self.contamination_amount = 0.1 -- How much radiation is added to a tile every second, does nothing if is_contaminant = false
    self.radiation_amount = 10 -- How much radiation is added to entities every second
    self.is_contaminant = false -- Should contaminate tiles?

    self.affected_ents = {  } -- A list of entites currently in the radiation radius
    self.spread_task = nil

    self.inst:StartUpdatingComponent(self)
end)

function RadiationSource:OnRemoveFromEntity()
    if self.spread_task then
        self.spread_task:Cancel()
        self.spread_task = nil
    end

    for ent, _ in pairs(self.affected_ents) do
        if ent then
            ent.components.radiation_sources[self.inst] = nil
        end
    end
end

function RadiationSource:SetRadius(radius)
    self.radius = radius
end

function RadiationSource:SetContaminationAmount(amount)
    self.contamination_amount = amount
end
    
function RadiationSource:SetRadiationAmount(amount)
    self.radiation_amount = amount
end

function RadiationSource:ShouldContaminateTiles(contaminate)
    self.is_contaminant = contaminate

    if contaminate then
        if self.spread_task == nil then
            self.spread_task = self.inst:DoPeriodicTask(1, ContaminateTiles)
        end
    else
        if self.spread_task then
            self.spread_task:Cancel()
            self.spread_task = nil
        end
    end
end

function RadiationSource:OnUpdate()
    local x, y, z = self.inst.Transform:GetWorldPosition()
    local new_ents = TheSim:FindEntities(x, y, z, self.radius, { "radiation" })

    for ent, _ in pairs(self.affected_ents) do
        if not table.contains(new_ents, ent) then
            self.affected_ents[ent] = nil
            ent.components.radiation.radiation_sources[self.inst] = nil
        end
    end

    for i, ent in ipairs(new_ents) do
        if ent ~= self.inst then
            if self.affected_ents[ent] == nil then
                self.affected_ents[ent] = true
                ent.components.radiation.radiation_sources[self.inst] = true
            end
        end
    end
end

return RadiationSource