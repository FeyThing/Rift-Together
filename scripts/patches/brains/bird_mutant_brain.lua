return function(self)
    local PriorityNode = _G.PriorityNode
    local IfNode = _G.IfNode
    local WhileNode = _G.WhileNode
    local ActionNode = _G.ActionNode
    local ConditionNode = _G.ConditionNode
    local Wander = _G.Wander
    local DoAction = _G.DoAction
    local StandStill = _G.StandStill
    local BrainCommon = require("brains/braincommon")

    local function CanBirdAttack(inst)
        if inst.components.combat:InCooldown() or inst.sg:HasStateTag("busy") then
            return nil
        end

        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = _G.TheSim:FindEntities(x, y, z, inst.components.combat.attackrange)
        local potentials = {  }
        for i, ent in ipairs(ents) do
            if ent:HasTag("player") or (ent.components.follower and ent.components.follower:GetLeader() and ent.components.follower:GetLeader():HasTag("player")) then
                table.insert(potentials,ent)
            end
        end

        if #potentials > 0 then
            return potentials[math.random(1, #potentials)]
        end
    end

    local function AttackTarget(inst)
        local target = CanBirdAttack(inst)
        if target then
            inst.components.combat:TryAttack(target)
        end
    end

    local function ShouldSpit(inst)
        if inst.components.timer:TimerExists("spit_cooldown") then
            return false
        end

        return inst.components.combat.target and
            inst.components.combat.target:IsValid() and
            inst:GetDistanceSqToInst(inst.components.combat.target) <= TUNING.MUTANT_BIRD_SPIT_RANGE*TUNING.MUTANT_BIRD_SPIT_RANGE
    end

    local function Spit(inst)
        return _G.BufferedAction(inst, inst.components.combat.target, _G.ACTIONS.TOSS)
    end

    local function ShouldWaitToSpit(inst)
        return inst.components.combat.target and inst.components.combat.target:IsValid() and inst:GetDistanceSqToInst(inst.components.combat.target) <= 4*4
    end

    local function HasSwarmTarget(inst)
        return inst.components.entitytracker:GetEntity("swarmTarget")
    end

    local function IsFlying(inst)
        return inst.sg:HasStateTag("flight")
    end

    local node = WhileNode(function() return not HasSwarmTarget(self.inst) end, "DoesntHaveASwarmTarget",
        PriorityNode({
            IfNode(function() return not IsFlying(self.inst) end, "IsNotFlying",
                PriorityNode({
                    BrainCommon.PanicTrigger(self.inst),

                    IfNode(function() return self.inst:HasTag("bird_mutant_spitter") end, "IsSpitter",
                        PriorityNode({
                            WhileNode(function() return ShouldSpit(self.inst) end, "Spit",
                                DoAction(self.inst, Spit)
                            ),

                            IfNode(function() return ShouldWaitToSpit(self.inst) end, "WaitToSpit",
                                StandStill(self.inst)
                            )
                        }, 0.25)
                    ),

                    IfNode(function() return CanBirdAttack(self.inst) end, "Attack",
                        ActionNode(function() AttackTarget(self.inst) end)
                    ),

                    Wander(self.inst)
                }, 0.25)
            ),

            ConditionNode(function() return true end) -- LukaS: Used to skip the original bird_mutant_brain code
        }, 0.25)
    )

    if self.bt then
        table.insert(self.bt.root.children, 1, node)
    end
end