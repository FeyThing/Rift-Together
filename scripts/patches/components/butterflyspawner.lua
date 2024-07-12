return function(self)
    -- Keep in sync with components/butterflyspawner.lua
    local _activeplayers = {  }
    local _scheduledtasks = {  }
    local _worldstate = _G.TheWorld.state
    local _updating = false
    local _maxbutterflies = TUNING.MAX_BUTTERFLIES

    local function SpawnButterfly(flower)
        local radiation = _G.TheWorld.components.radiationmanager:GetAtPoint(flower.Transform:GetWorldPosition())
        radiation = radiation or 0
        if radiation >= TUNING.START_MOONMOTH_SPAWN_RADIATION then
            return _G.SpawnPrefab("moonbutterfly")
        elseif radiation < TUNING.ALLOW_BUTTERFLY_SPAWN_RADIATION_LIMIT then
            return _G.SpawnPrefab("butterfly")
        end
    end

    local function GetSpawnPoint(player)
        local radius = 25
        local mindistance = 36
        local x, y, z = player.Transform:GetWorldPosition()
        local flowers = _G.TheSim:FindEntities(x, y, z, radius, { "flower" })
        for i, v in ipairs(flowers) do
            while v and player:GetDistanceSqToInst(v) <= mindistance do
                table.remove(flowers, i)
                v = flowers[i]
            end
        end

        return _G.next(flowers) ~= nil and flowers[math.random(1, #flowers)] or nil
    end

    local function SpawnButterflyForPlayer(player, reschedule)
        local pt = player:GetPosition()
        local ents = _G.TheSim:FindEntities(pt.x, pt.y, pt.z, 64, { "butterfly" })
        if #ents < _maxbutterflies then
            local spawnflower = GetSpawnPoint(player)
            if spawnflower then
                local butterfly = SpawnButterfly(spawnflower)
                if butterfly then
                    if butterfly.components.pollinator then
                        butterfly.components.pollinator:Pollinate(spawnflower)
                    end
        
                    if butterfly.components.homeseeker then
                        butterfly.components.homeseeker:SetHome(spawnflower)
                    end
                    -- KAJ: TODO: Butterflies can be despawned before getting to the rest of the logic if this is above the homeseeker
                    butterfly.Physics:Teleport(spawnflower.Transform:GetWorldPosition())

                    if butterfly.prefab == "moonbutterfly" then
                        butterfly.sg:GoToState("takeoff")
                    end
                end
            end
        end

        _scheduledtasks[player] = nil
        reschedule(player)
    end

    local function ScheduleSpawn(player, initialspawn)
        if _scheduledtasks[player] == nil then
            local basedelay = initialspawn and 0.3 or 10
            _scheduledtasks[player] = player:DoTaskInTime(basedelay + math.random() * 10, SpawnButterflyForPlayer, ScheduleSpawn)
        end
    end

    local function CancelSpawn(player)
        if _scheduledtasks[player] then
            _scheduledtasks[player]:Cancel()
            _scheduledtasks[player] = nil
        end
    end

    local function OnPlayerJoined(inst, player)
        for i, v in ipairs(_activeplayers) do
            if v == player then
                return
            end
        end

        table.insert(_activeplayers, player)

        if _updating then
            ScheduleSpawn(player, true)
        end
    end

    local function OnPlayerLeft(inst, player)
        for i, v in ipairs(_activeplayers) do
            if v == player then
                CancelSpawn(player)
                table.remove(_activeplayers, i)

                return
            end
        end
    end

    local function ToggleUpdate(force)
        if _worldstate.isday and not _worldstate.iswinter and _maxbutterflies > 0 then
            if not _updating then
                _updating = true
                for i, v in ipairs(_activeplayers) do
                    ScheduleSpawn(v, true)
                end
            elseif force then
                for i, v in ipairs(_activeplayers) do
                    CancelSpawn(v)
                    ScheduleSpawn(v, true)
                end
            end
        elseif _updating then
            _updating = false
            for i, v in ipairs(_activeplayers) do
                CancelSpawn(v)
            end
        end
    end

    -- LukaS: Removes the most recently added event listener, can be used without needing the callback function
    local function RemoveMostRecentEventCallback(inst, event, source)
        source = source or inst
        local event_fns = inst.event_listening[event][source]
        if event_fns then
            local fn = event_fns[#event_fns]
            if fn then
                inst:RemoveEventCallback(event, fn, source)
            else
                print("ERROR: Function list is empty!")
            end
        end
    end

    local function StopWatchingMostRecentWorldState(inst, state)
        local worldstate_fns = inst.worldstatewatching[state]
        if worldstate_fns then
            local fn = worldstate_fns[#worldstate_fns]
            if fn then
                inst:StopWatchingWorldState(state, fn)
            else
                print("ERROR: Function list is empty!")
            end
        end
    end

    RemoveMostRecentEventCallback(self.inst, "ms_playerjoined", _G.TheWorld)
    RemoveMostRecentEventCallback(self.inst, "ms_playerleft", _G.TheWorld)
    StopWatchingMostRecentWorldState(self.inst, "isday")
    StopWatchingMostRecentWorldState(self.inst, "iswinter")

    self.inst:WatchWorldState("isday", ToggleUpdate)
    self.inst:WatchWorldState("iswinter", ToggleUpdate)
    self.inst:ListenForEvent("ms_playerjoined", OnPlayerJoined, _G.TheWorld)
    self.inst:ListenForEvent("ms_playerleft", OnPlayerLeft, _G.TheWorld)

    function self:OnPostInit()
        ToggleUpdate(true)
    end
end