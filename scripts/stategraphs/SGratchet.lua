local State = GLOBAL.State
local FRAMES = GLOBAL.FRAMES
local EventHandler = GLOBAL.EventHandler
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local TimeEvent = GLOBAL.TimeEvent
local ActionHandler = GLOBAL.ActionHandler
local ACTIONS = GLOBAL.ACTIONS
local TheNet = GLOBAL.TheNet
local SpawnPrefab = GLOBAL.SpawnPrefab
local PlayFootstep = GLOBAL.PlayFootstep
local Vector3 = GLOBAL.Vector3
local STRINGS = GLOBAL.STRINGS

AddStategraphEvent("wilson",
	EventHandler("ratchet_redirect_locomote", function(inst, data)
        inst.sg:GoToState("ratchet_dodge", data)
    end)
)


AddStategraphState("wilson", 
	State
    {
        name = "ratchet_dodge",
        tags = {"busy", "evade", "no_stun", "canrotate", "nopredict"},

        onenter = function(inst, data)
			inst.components.locomotor:Stop()
       
            inst.sg:SetTimeout(.8)
            inst.AnimState:PlayAnimation("dodgeroll_pre")

            inst.AnimState:PushAnimation("dodgeroll")
           
            inst.Physics:SetMotorVelOverride(10,0,0)
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
			
            inst.SoundEmitter:PlaySound("turnoftides/common/together/boat/jump")
			
            inst.was_invincible = inst.components.health.invincible
            inst.components.health:SetInvincible(true)
            inst.sg:AddStateTag("noattack")
            
            inst.last_dodge_time = GLOBAL.GetTime()
			inst.dodgetime:set(inst.dodgetime:value() == false and true or false)
			
			if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
			inst.sg:SetTimeout(.8)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("ratchet_dodge_pst")
        end,

        onexit = function(inst)
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()
            inst.components.locomotor:Stop()
            
            inst.components.locomotor:SetBufferedAction(nil)
            if not inst.was_invincible then
                inst.components.health:SetInvincible(false)
            end
            inst.sg:RemoveStateTag("noattack")

            inst.was_invincible = nil
        end,
    }
)

AddStategraphState("wilson",
	State
    {
        name = "ratchet_dodge_pst",
        tags = {"evade","no_stun"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("dodgeroll_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end ),
        }
    }
)

AddStategraphState("wilson_client", 
	State
    {
        name = "ratchet_dodge",
        tags = {"busy", "evade","no_stun","canrotate"},

        onenter = function(inst, data)
			inst.entity:SetIsPredictingMovement(false)

            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("dodgeroll_pre")
            inst.AnimState:PushAnimation("dodgeroll", false)

            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            
            inst.last_dodge_time = GLOBAL.GetTime()
			inst.dodgetime:set(inst.dodgetime:value() == false and true or false)
			inst:PerformPreviewBufferedAction()
			inst.sg:SetTimeout(1)
        end,
		
		onupdate = function(inst)
            if inst:HasTag("working") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle")
        end,

        onexit = function(inst)
            inst.entity:SetIsPredictingMovement(true)
        end,
    }
)
