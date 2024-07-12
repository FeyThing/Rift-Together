return function(self)
    self.states["glide"].tags["flight"] = true

    self.events["flyaway"] = _G.EventHandler("flyaway", function(inst)
        inst.sg:GoToState("flyaway")
    end)

    self.states["flyaway"] = _G.State{
        name = "flydown",
        tags = { "busy", "flight" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.sg:SetTimeout(0.1 + math.random()*0.2)
            inst.sg.statemem.vert = math.random() < 0.5

            inst.SoundEmitter:PlaySound(inst.sounds.takeoff)

            inst.AnimState:PlayAnimation(inst.sg.statemem.vert and "takeoff_vertical_pre" or "takeoff_diagonal_pre")
        end,

        ontimeout = function(inst)
            if inst.sg.statemem.vert then
                inst.AnimState:PushAnimation("takeoff_vertical_loop", true)
                inst.Physics:SetMotorVel(math.random()*4 - 2, math.random()*5 + 15, math.random()*4 - 2)
            else
                inst.AnimState:PushAnimation("takeoff_diagonal_loop", true)
                inst.Physics:SetMotorVel(math.random()*8 + 8, math.random()*5 + 15, math.random()*4 - 2)
            end

			inst.DynamicShadow:Enable(false)
        end,

        timeline = {
            _G.TimeEvent(2, function(inst)
                inst:Remove()
            end),
        }
    }
end