return {
    State{
        name = "hg_spawn",
        tags = { "busy" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("jump", false)
            inst.AnimState:PushAnimation("jump_pst", false)

            inst.AnimState:SetScale(0.35, 0.35)

            inst.sg.statemem.t = 0
            inst.sg.statemem.duration = inst.AnimState:GetCurrentAnimationLength()

            inst:StopBrain()
            ToggleOffPhysics(inst)
        end,

        onexit = function(inst)
            inst:RestartBrain()
            ToggleOnPhysics(inst)
            inst.AnimState:SetScale(1, 1)
        end,

        onupdate = function(inst, dt)
            inst.Physics:SetMotorVel(TUNING.HG.PRIZE_MOB_VEL:Get())
            if not inst.sg.statemem.t then
                return
            end

            inst.sg.statemem.t = math.min(inst.sg.statemem.t + dt, inst.sg.statemem.duration)

            if inst.sg.statemem.t >= inst.sg.statemem.duration then
                inst.AnimState:SetScale(1, 1)

                inst.sg.statemem.t = nil
            else    
                local percent = inst.sg.statemem.t / inst.sg.statemem.duration
                local s = Lerp(0.35, 1, percent)
                inst.AnimState:SetScale(s, s)
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },
}