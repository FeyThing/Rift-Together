local function GenerateAndSpawnJunkShadePositions(inst)
    local self = inst.components.junkshade
    if self == nil then
        return
    end
    self:GenerateJunkShadePositions()
    self:SpawnShadows()
end

local JunkShade = Class(function(self, inst)
    self.inst = inst

    self.range = math.floor(TUNING.SHADE_CANOPY_RANGE/4)

    self.junkshade_positions = {}
    self.spawned = false

    inst:DoTaskInTime(0, GenerateAndSpawnJunkShadePositions)
end)

function JunkShade:OnRemoveEntity()
    self:DespawnShadows(true)
    self:RemoveJunkShadePositions()
end
JunkShade.OnRemoveFromEntity = JunkShade.OnRemoveEntity

Global_Junkshade = {}
local Junkshade = Global_Junkshade

function JunkShade:GenerateJunkShadePositions()
    local x,y,z = self.inst.Transform:GetWorldPosition()
    for i = -self.range, self.range do
        for t = -self.range, self.range do
            if math.random() < 0.8 and ((t*t) + (i*i)) <= self.range*self.range then
                local newx = math.floor((x + i * 4) / 4) * 4 + 2
                local newz = math.floor((z + t * 4) / 4) * 4 + 2

                local shadetile_key = newx.."-"..newz
                local shadetile = Junkshade[shadetile_key]
                if not shadetile then
                    table.insert(self.junkshade_positions, {newx, newz})
                    Junkshade[shadetile_key] = {refs = 1, spawnrefs = 0}
                else
                    shadetile.refs = shadetile.refs + 1
                end
            end
        end
    end
end

function JunkShade:RemoveJunkShadePositions()
    for i, v in ipairs(self.junkshade_positions) do
        local x, z = v[1], v[2]
        local shadetile_key = x.."-"..z
        local shadetile = Junkshade[shadetile_key]
        shadetile.refs = shadetile.refs - 1
        if shadetile.refs == 0 then
            Junkshade[shadetile_key] = nil
        end
    end
end

function JunkShade:OnEntitySleep()
    if not IsTableEmpty(self.junkshade_positions) then
        self:DespawnShadows()
    end
end

function JunkShade:OnEntityWake()
    if not IsTableEmpty(self.junkshade_positions) then
        self:SpawnShadows()
    end
end

function JunkShade:SpawnShadows()
    if self.spawned or not self.inst.entity:IsAwake() then return end

    for i, v in ipairs(self.junkshade_positions) do
        local x, z = v[1], v[2]
        local shadetile = Junkshade[x.."-"..z]
        shadetile.spawnrefs = shadetile.spawnrefs + 1
        if shadetile.spawnrefs == 1 then
            shadetile.id = SpawnJunkShade(x, z)
        end
    end

    self.spawned = true
end

function JunkShade:DespawnShadows(ignore_entity_sleep)
    if not self.spawned or (not ignore_entity_sleep and self.inst.entity:IsAwake()) then return end

    for i, v in ipairs(self.junkshade_positions) do
        local x, z = v[1], v[2]
        local shadetile = Junkshade[x.."-"..z]
        shadetile.spawnrefs = shadetile.spawnrefs - 1
        if shadetile.spawnrefs == 0 then
            DespawnJunkShade(shadetile.id)
            shadetile.id = nil
        end
    end

    self.spawned = false
end

return JunkShade