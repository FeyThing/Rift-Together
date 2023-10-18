local STATES = {
    State{
        name = "getitemking",
        tags = {"busy"},
        onenter = function(inst, data)
            inst.components.talker:Say(STRINGS["MONKEY_QUEEN_BANANAS"][math.random(1,#STRINGS["MONKEY_QUEEN_BANANAS"])])
            inst.AnimState:OverrideSymbol("swap_item", "cave_banana", "cave_banana01")
            inst.AnimState:PlayAnimation("receive_item")

            inst.SoundEmitter:PlaySound("monkeyisland/monkeyqueen/receive_item")

            inst.sg.statemem.giver = data.giver
        end,

        events = 
        {
            EventHandler("animover", function(inst) 
				inst.sg:GoToState("giveking", {giver = inst.sg.statemem.giver})
            end)
        },
    },

    State{
        name = "pickcursedtocken",
        tags = {"busy"},
        onenter = function(inst, data)
            inst.AnimState:PlayAnimation("curse_success")
            inst.SoundEmitter:PlaySound("monkeyisland/monkeyqueen/remove_curse_success")
			
            inst.sg.statemem.giver = data.giver
        end,

        events =
        {
            EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle", {giver = inst.sg.statemem.giver})
            end)
        },
    },

    State{
        name = "giveking",
        tags = {"busy"},
        onenter = function(inst, data)
            inst.components.talker:Say(STRINGS["MONKEY_QUEEN_REMOVE_CURSE"][math.random(1,#STRINGS["MONKEY_QUEEN_REMOVE_CURSE"])])
            inst.AnimState:PlayAnimation("curse_remove_pre")
            inst.AnimState:PushAnimation("curse_fail", false)
            inst.SoundEmitter:PlaySound("monkeyisland/monkeyqueen/channel_magic_pre")
            inst.sg.statemem.giver = data.giver
        end,

        timeline =
        {
            TimeEvent(35 * FRAMES, function(inst)
                inst:GiveReward()
            end),
        },

        events = 
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("idle")
            end)
        },
    },
}

return STATES
