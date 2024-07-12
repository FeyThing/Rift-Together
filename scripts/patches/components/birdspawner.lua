return function(self)
    local MOON_BIRDS =  {
        "bird_mutant",
        "bird_mutant_spitter"
    }

    local function RollForMoonBird(rad)
        return math.random()*40 + 30 <= rad -- LukaS: Linear chance, the higher the radiation the higher the chance
    end

    local old_SpawnBird = self.SpawnBird
    function self:SpawnBird(spawnpoint, ignorebait)
        local radiation = _G.TheWorld.components.radiationmanager:GetAtPoint(spawnpoint:Get())
        radiation = radiation or 0

        if radiation > TUNING.ALLOW_BIRD_SPAWN_RADIATION_LIMIT and RollForMoonBird(radiation) then
            local prefab = MOON_BIRDS[math.random(#MOON_BIRDS)]
            local bird = _G.SpawnPrefab(prefab)
            spawnpoint.y = 15
			bird.Transform:SetPosition(spawnpoint:Get())
            bird.sg:GoToState("glide") -- LukaS: This works
            -- bird:PushEvent("arrive") --       but this doesn't ???
            bird:DoTaskInTime(math.random()*10 + 5, function(inst) inst:PushEvent("flyaway") end)

            return bird -- LukaS: Doesn't even do anything °_o
        else
            return old_SpawnBird(self, spawnpoint, ignorebait)
        end
    end
end