local RIFTSPAWN_TIMERNAME = "dimensional_rift_spawn_timer"

local RiftSpawner = Class(function(self, inst)
    assert(TheWorld.ismastersim, "RiftSpawner should not exist on the client")
    self.inst = inst

    -- Cache
    self._worldsettingstimer = TheWorld.components.worldsettingstimer
    self._map = TheWorld.Map

    -- SPAWN MODES --  1: never --  2: rare --  3: default --  4: often --  5: always
    self.spawnmode = 3

    self._rifts_enabled = false

    self.rifts = {}
    self.rifts_count = 0

    self._worldsettingstimer:AddTimer(
        RIFTSPAWN_TIMERNAME,
        TUNING.RIFTS_SPAWNDELAY + 1,
        TUNING.SPAWN_RIFTS ~= 0,
        function() self:OnRiftTimerDone() end
    )
end)

--------------------------------------------------------------------------------

local MINIMUM_DSQ_FROM_PREVIOUS_RIFT = 15 * TILE_SCALE
MINIMUM_DSQ_FROM_PREVIOUS_RIFT = MINIMUM_DSQ_FROM_PREVIOUS_RIFT * MINIMUM_DSQ_FROM_PREVIOUS_RIFT
function RiftSpawner:IsPointNearPreviousSpawn(x, z)
    for rift, rift_prefab in pairs(self.rifts) do
        local rx, _, rz = rift.Transform:GetWorldPosition()
        if distsq(x, z, rx, rz) < MINIMUM_DSQ_FROM_PREVIOUS_RIFT then
            return true
        end
    end
    return false
end

function RiftSpawner:OnRiftRemoved(rift)
    if self.rifts[rift] then
        self.rifts[rift] = nil
        self.rifts_count = self.rifts_count - 1

        if self.spawnmode ~= 1 and not self._worldsettingstimer:ActiveTimerExists("dimensional_rift_spawn_timer") then
            if self.rifts_count < TUNING.DIMENSIONAL_RIFTS.MAX_AMOUNT then
                self._worldsettingstimer:StartTimer(RIFTSPAWN_TIMERNAME, TUNING.RIFTS_SPAWNDELAY)
            end
        end
    end
end

function RiftSpawner:AddRiftToPool(rift, rift_prefab)
    if self.rifts[rift] == nil then
        self.rifts[rift] = rift_prefab
        self.rifts_count = self.rifts_count + 1
        self.inst:ListenForEvent("onremove", function() self:OnRiftRemoved(rift) end, rift)
        TheWorld:PushEvent("ms_riftaddedtopool", {rift = rift})
    end
end

function RiftSpawner:SpawnRift(forced_pos)
    local rift_prefab = "dimensional_rift"

    local x,y,z
    if forced_pos then
        x, z = forced_pos.x, forced_pos.z
    else
        x, y, z = self._map:FindBestSpawningPointForArena(function() return true end)
    end

    if not x then
        return nil
    end

    if self:IsPointNearPreviousSpawn(x, z) then
        return nil
    end

    local rift = SpawnPrefab(rift_prefab)
    rift.Transform:SetPosition(x, 0, z)

    self:AddRiftToPool(rift, rift_prefab)

    return rift
end

function RiftSpawner:TryToSpawnRift(forced_pos)
    if self.rifts_count < TUNING.DIMENSIONAL_RIFTS.MAX_AMOUNT then
        self._map:StartFindingGoodArenaPoints()
        self.inst:DoTaskInTime(1, function()
            self:SpawnRift(forced_pos)
        end)
    end
end

function RiftSpawner:OnRiftTimerDone()
print ("Is rifts working?")
    if self.spawnmode == 1 then
        return
    end

    if self.rifts_count < TUNING.DIMENSIONAL_RIFTS.MAX_AMOUNT then
        local spawned_rift = self:SpawnRift()

        if not spawned_rift then
            self._worldsettingstimer:StartTimer(RIFTSPAWN_TIMERNAME, TUNING.TOTAL_DAY_TIME)
        elseif (self.rifts_count + 1) < TUNING.DIMENSIONAL_RIFTS.MAX_AMOUNT then
            self._worldsettingstimer:StartTimer(RIFTSPAWN_TIMERNAME, TUNING.RIFTS_SPAWNDELAY)
        end
    end
end

function RiftSpawner:SetDifficulty(src, difficulty)
	if difficulty == "never" then
		self.spawnmode = 1
        self._worldsettingstimer:StopTimer(RIFTSPAWN_TIMERNAME)
	else
        if difficulty == "rare" then
		    self.spawnmode = 2
        elseif difficulty == "default" then
            self.spawnmode = 3
        elseif difficulty == "often" then
            self.spawnmode = 4
        elseif difficulty == "always" then
            self.spawnmode = 5
        end

        if self._worldsettingstimer:ActiveTimerExists(RIFTSPAWN_TIMERNAME) then
            local time_left = self._worldsettingstimer:GetTimeLeft(RIFTSPAWN_TIMERNAME)
            local new_time = math.min(time_left, TUNING.RIFTS_SPAWNDELAY)
            self._worldsettingstimer:SetTimeLeft(RIFTSPAWN_TIMERNAME, new_time)
        end
	end
end

function RiftSpawner:TryToStartTimer(src)
    if self.spawnmode ~= 1 and not self._worldsettingstimer:ActiveTimerExists(RIFTSPAWN_TIMERNAME) then
        self._worldsettingstimer:StartTimer(RIFTSPAWN_TIMERNAME, TUNING.RIFTS_SPAWNDELAY)
        self._map:StartFindingGoodArenaPoints()
    end
end

function RiftSpawner:EnableRifts(src)
    self.rifts_enabled = true
    self:TryToStartTimer(src)
end

function RiftSpawner:SetEnabledSetting(src, enabled_difficulty)
    if enabled_difficulty == "never" then
        self.rifts_enabled = false
        self._worldsettingstimer:StopTimer(RIFTSPAWN_TIMERNAME)
    elseif enabled_difficulty == "always" then
        self:EnableRifts(src)
    end
end

--------------------------------------------------------------------------------
-- Getters
--------------------------------------------------------------------------------

function RiftSpawner:GetRifts()
    return self.rifts
end

function RiftSpawner:GetEnabled() -- Any type update accordingly.
    return self.rifts_enabled
end

--------------------------------------------------------------------------------
-- Save / Load
--------------------------------------------------------------------------------

function RiftSpawner:OnSave()
    local data = {
        timerfinished = (not self._worldsettingstimer:ActiveTimerExists(RIFTSPAWN_TIMERNAME)) or nil,
        rift_guids = {},
        _rifts_enabled = self.rifts_enabled,
    }
    local ents = {}
    for rift, rift_prefab in pairs(self.rifts) do
        if rift_prefab then
            table.insert(data.rift_guids, rift.GUID)
            table.insert(ents, rift.GUID)
        end
    end

    return data, ents
end

function RiftSpawner:OnLoad(data)
    if data.timerfinished then
        self._worldsettingstimer:StopTimer(RIFTSPAWN_TIMERNAME)
    end

    self.rifts_enabled = data._rifts_enabled or self.rifts_enabled
end

function RiftSpawner:LoadPostPass(newents, data)
    if data then
        if data.rift_guids then
            for _, rift_guid in ipairs(data.rift_guids) do
                local new_ent = newents[rift_guid]
                if new_ent and new_ent.entity then
                    self:AddRiftToPool(new_ent.entity, new_ent.entity.prefab)
                end
            end
        end
    end

    if self.rifts_enabled then
        self:EnableRifts()
    end

    if self._worldsettingstimer:ActiveTimerExists(RIFTSPAWN_TIMERNAME) then
        self._map:StartFindingGoodArenaPoints()
    end
end

--------------------------------------------------------------------------------
-- Debug
--------------------------------------------------------------------------------

function RiftSpawner:GetDebugString()
    return ""
end

return RiftSpawner
