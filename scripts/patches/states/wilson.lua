local CachedBushes = {}
local BLOWDART_SPEED = 1

local function DoHurtSound(inst)
	if inst.hurtsoundoverride then
		inst.SoundEmitter:PlaySound(inst.hurtsoundoverride, nil, inst.hurtsoundvolume)
	elseif not inst:HasTag("mime") then
		inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/hurt", "player_hurt", inst.hurtsoundvolume)
	end
end

local function ShakeBush(inst)
    if inst.components.pickable and
	not inst.components.pickable:CanBePicked() and
	inst.components.pickable:IsBarren() then
        inst.AnimState:PlayAnimation("shake_dead")
        inst.AnimState:PushAnimation("dead", false)
    else
        inst.AnimState:PlayAnimation("shake")
        inst.AnimState:PushAnimation("idle")
    end
	inst.AnimState:SetTime(FRAMES * 25)
end

local function CreateFakeBush(player)
	if not player then return end

	if TheWorld.Map:IsOceanAtPoint(player.Transform:GetWorldPosition()) then
		return
	end

	local ic = player.components
	
	-- player.AnimState:SetPercent(0, 0)
	player.AnimState:SetErosionParams(1, 0.1, 1.0)
	player.mass = 75
	
	player.Physics:SetCollides(false)
	player.Physics:SetMass(0)
	player.DynamicShadow:Enable(false)
	
	ic.talker:IgnoreAll("bushhat")
	
	local bush = SpawnAt("berrybush", player)
	CachedBushes[player.entity] = bush
	bush:DoTaskInTime(0, ShakeBush)
	
	bush.persists = false
	bush.components.pickable:MakeEmpty()
	
	-- if bush.components.diseaseable ~= nil then
	-- 	bush.components.diseaseable:SetDiseasedFn(function() return end)
	-- end
	
	if bush.components.pickable ~= nil then
		bush.components.pickable.Pick = function(self, picker)
			if player.deathcause == nil then player.sg:GoToState("idle") end
			return 
		end
	end

	if bush.components.workable ~= nil then
		bush.components.workable.onfinish = nil
		bush.components.workable.onwork = function(self, worker, numworks)
			if player.deathcause == nil then
				player.sg:GoToState("hit")
				player.components.combat:GetAttacked(worker, TUNING.SHOVEL_DAMAGE)
			end
			return
		end
	end
	
	if bush.components.burnable ~= nil then
		bush.components.burnable.Ignite = function(self, immediate, source)
			player.components.burnable:Ignite(immediate, source)
			if player.deathcause == nil then player.sg:GoToState("idle") end
			return
		end
	end
	
	bush:ListenForEvent("onremove", function(player)
		player.Physics:SetMass(player.mass)
		CachedBushes[player.entity]:Remove()
		CachedBushes[player.entity] = nil
	end, player)
end

local function GetUnequipState(inst, data)
	return (inst:HasTag("beaver") and "item_in")
		or (data.eslot ~= EQUIPSLOTS.HANDS and "item_hat")
		or (not data.slip and "item_in")
		or (data.item ~= nil and data.item:IsValid() and "tool_slip")
		or "toolbroke"
		, data.item
end

local plant_symbols = 
{
    "waterpuddle",
    "sparkle",
    "puddle",
    "plant",
    "lunar_mote3",
    "lunar_mote",
    "glow",
    "blink"
}

local SymbolsToHide = 
{
    "hand",
    "hand",
    "tail",
    "torso",
    "torso_pelvis",
    "leg",
    "skirt",
	"arm_upper",
	"arm_upper_skin",
	"arm_lower",
	"arm_lower_cuff",
	"face",
	"swap_face",
	"hair",
	"hair_hat",
	"hair_front",
	"hair_front",
	"headbase",
	"headbase_hat",
    "foot",
    "hairpigtails",
    "hairfront",
    "torso_pelvis_wide",
    "torso_wide",
    "cheeks",
    "swap_object",
    "swap_hat",
    "swap_body",
}

local function DoPortalTint(inst, val)
    if val > 0 then
        inst.components.colouradder:PushColour("portaltint", 154 / 255 * val, 23 / 255 * val, 19 / 255 * val, 0)
        val = 1 - val
        inst.AnimState:SetMultColour(val, val, val, 1)
    else
        inst.components.colouradder:PopColour("portaltint")
        inst.AnimState:SetMultColour(1, 1, 1, 1)
    end
end

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local function UnFossilize(inst)
	if inst._fossilizefx then
		inst._fossilizefx:UnFossilize()
		inst._fossilizefx = nil
	end
	inst._hits_count = nil
	inst.AnimState:Resume()
	inst.SoundEmitter:SetMute(false)
	if not inst.components.health:IsDead() then
		inst.sg:GoToState("idle", "hit")
	end
	inst:RemoveEventCallback("death", UnFossilize)
end

local function OnAttackFossilized(inst, data)
	inst._hits_count = (inst._hits_count or 0) + 1
	if inst._fossilizefx then
		inst._fossilizefx.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_hit")
	end
	if inst._hits_count >= TUNING.HG.FOSSILIZIATION.HITSTOUNBLOCK or data.stimuli then
		UnFossilize(inst)
		inst:RemoveEventCallback("attacked", OnAttackFossilized)
	end
end

local function ListenForAttacks(inst, n, fn)
	inst._hits_count = 0
	inst:ListenForEvent("attacked", OnAttackFossilized)
end

local STATES = {
    State{
        name = "wanda_pocketpower",
        tags = { "busy", "doing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("useitem_pre") -- 8 frames
            inst.AnimState:PushAnimation("pocketwatch_cast", false)
            inst.AnimState:PushAnimation("useitem_pst", false)
			inst.AnimState:OverrideSymbol("watchprop", "pocketwatch_warp", "watchprop")
        end,

		timeline = 
		{
            TimeEvent(8 * FRAMES, function(inst)
				inst.AnimState:Show("ARM_normal")

				inst.sg.statemem.stafffx = SpawnPrefab((inst.components.rider ~= nil and inst.components.rider:IsRiding()) and "pocketwatch_cast_fx_mount" or "pocketwatch_cast_fx")
				inst.sg.statemem.stafffx.entity:SetParent(inst.entity)
				inst.sg.statemem.stafffx:SetUp({ 1, 1, 1 })

				inst.SoundEmitter:PlaySound("wanda2/characters/wanda/watch/heal")
            end),
            TimeEvent(16 * FRAMES, function(inst)
				if inst.sg.statemem.stafffx ~= nil then
					inst.sg.statemem.stafflight = SpawnPrefab("staff_castinglight_small")
					inst.sg.statemem.stafflight.Transform:SetPosition(inst.Transform:GetWorldPosition())
					inst.sg.statemem.stafflight:SetUp({ 1, 1, 1 }, 0.75, 0)
				end
            end),
            TimeEvent(40 * FRAMES, function(inst)
				inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(48 * FRAMES, function(inst)
				if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
					inst.AnimState:Show("ARM_carry")
					inst.AnimState:Hide("ARM_normal")
				end
            end),
		},

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
	                inst.sg:GoToState("idle")
                end
            end),
        },

		onexit = function(inst)
			if inst.sg.statemem.stafffx ~= nil and inst.sg.statemem.stafffx:IsValid() then
				inst.sg.statemem.stafffx:Remove()
			end
			if inst.sg.statemem.stafflight ~= nil and inst.sg.statemem.stafflight:IsValid() then
				inst.sg.statemem.stafflight:Remove()
			end

            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry")
                inst.AnimState:Hide("ARM_normal")
            end
		end,
    },
	State{
        name = "powerwhistle",
        tags = { "doing", "busy", "playing", "nopredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("whistle", false)
            inst.AnimState:OverrideSymbol("hound_whistle01", "houndwhistle", "hound_whistle01")
            inst.AnimState:Show("ARM_normal")
        end,

        timeline =
        {
            TimeEvent(20 * FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/common/together/houndwhistle")
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry")
                inst.AnimState:Hide("ARM_normal")
            end
        end,
    },
    State{
        name = "peertelescope",
        tags = {"doing", "busy", "canrotate", "nopredict"},

        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            local act = inst:GetBufferedAction()

			if act then
				local pt = act.GetActionPoint and act:GetActionPoint() or act.pos
				if pt then
					inst:ForceFacePoint(pt.x, pt.y, pt.z)
				end
			end
            inst.AnimState:PlayAnimation("telescope", false)
            inst.AnimState:PushAnimation("telescope_pst", false)

            inst.components.locomotor:Stop()
        end,

        timeline = 
        {
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/HUD/Together_HUD/learn_map") end),
        },

        events = {
            EventHandler("animover", function(inst)
                if not inst.AnimState:AnimDone() then
					inst:PerformBufferedAction()
				end
            end ),
            EventHandler("animqueueover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
            end ),
        },
    },
    State{
        name = "jumpoutportal",
        tags = { "doing", "busy", "canrotate", "nopredict", "nomorph" },

        onenter = function(inst)
            ToggleOffPhysics(inst)
            inst.components.locomotor:Stop()

            inst.sg.statemem.heavy = inst.components.inventory:IsHeavyLifting()

            inst.AnimState:PlayAnimation(inst.sg.statemem.heavy and "heavy_jumpout" or "jumpout")

            inst.Physics:SetMotorVel(4, 0, 0)
        end,

        timeline =
        {
            --Heavy lifting
            TimeEvent(4 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(3, 0, 0)
                end
            end),
            TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(2, 0, 0)
                end
            end),
            TimeEvent(12.2 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),
            TimeEvent(16 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(1, 0, 0)
                end
            end),

            --Normal
            TimeEvent(10 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(3, 0, 0)
                end
            end),
            TimeEvent(15 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(2, 0, 0)
                end
            end),
            TimeEvent(15.2 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),

            TimeEvent(17 * FRAMES, function(inst)
                inst.Physics:SetMotorVel(inst.sg.statemem.heavy and .5 or 1, 0, 0)
            end),
            TimeEvent(18 * FRAMES, function(inst)
                inst.Physics:Stop()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
        end,
    },
	
	State{
		name = "activatebernie",
		tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt" },
		
		onenter = function(inst, data)
			inst.hurtsoundoverride = "dontstarve/creatures/together/bernie_big/hit"
			inst.sg.mem.isbernieplayer = true
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("activate")
            inst.Transform:SetNoFaced()
		end,
		

        timeline =
        {
            TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bernie_big/activate") end),
            TimeEvent(36 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bernie_big/footstep", nil, .5) end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
					inst.Transform:SetFourFaced()
					inst.sg.mem.bernieplayer = true
				end
            end),
        },
	},
	
	State{
		name = "deactivatebernie",
		tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt" },
		
		onenter = function(inst, data)
			inst.hurtsoundoverride = nil
			inst.sg.mem.isbernieplayer = false
			inst.datadeath = data and data.death or false
            inst.components.locomotor:Stop()
			if inst.datadeath then
				inst.AnimState:PlayAnimation("death")
			else
				inst.AnimState:PlayAnimation("deactivate")
			end
            inst.Transform:SetNoFaced()
            inst.components.health:SetInvincible(true)
			if inst.datadeath then
				inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bernie_big/deactivate")
			end
		end,
		
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
				if inst.datadeath then
					inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bernie_big/footstep")
				end
            end),
			
            TimeEvent(5 * FRAMES, function(inst)
 				if inst.datadeath then
					inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bernie_big/vo_death_drop")
				end
            end),

            TimeEvent(27 * FRAMES, function(inst) 
 				if inst.datadeath then
					inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bernie_big/death") 
				end
			end),
            
			TimeEvent(31 * FRAMES, function(inst) 
 				if inst.datadeath then
					inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bernie_big/vo_death_collapse") 
				end
			end),

        },
		
		events = 
		{
			EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg.mem.bernieplayer = false
					inst.Transform:SetFourFaced()
					inst.components.health:SetInvincible(false)
                    inst:RemoveBerniePlayer(inst.datadeath)
				end
			end),
		},
	},
	
	-- State{
    --     name = "fake_portal_jump",
    --     tags = { "busy", "pausepredict", "nodangle", "nomorph" },

    --     onenter = function(inst)
    --         inst.components.locomotor:Stop()
    --         inst.AnimState:PlayAnimation("wortox_portal_jumpin")
    --         local x, y, z = inst.Transform:GetWorldPosition()
    --         SpawnPrefab("wortox_portal_jumpin_fx").Transform:SetPosition(x, y, z)
    --         inst.sg:SetTimeout(11 * FRAMES)
    --         if inst.components.playercontroller then
    --             inst.components.playercontroller:RemotePausePrediction()
    --         end
    --     end,

    --     onupdate = function(inst)
    --         if inst.sg.statemem.tints ~= nil then
    --             DoPortalTint(inst, table.remove(inst.sg.statemem.tints))
    --             if #inst.sg.statemem.tints <= 0 then
    --                 inst.sg.statemem.tints = nil
    --             end
    --         end
    --     end,

    --     timeline =
    --     {
    --         TimeEvent(FRAMES, function(inst)
    --             inst.SoundEmitter:PlaySound("dontstarve/creatures/together/toad_stool/infection_post", nil, .7)
    --             inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn", nil, .5)
    --         end),
    --         TimeEvent(2 * FRAMES, function(inst)
    --             inst.sg.statemem.tints = { 1, .6, .3, .1 }
    --             PlayFootstep(inst)
    --         end),
    --         TimeEvent(4 * FRAMES, function(inst)
    --             inst.sg:AddStateTag("noattack")
    --             inst.components.health:SetInvincible(true)
    --             inst.DynamicShadow:Enable(false)
    --         end),
    --     },

    --     ontimeout = function(inst)
    --         inst.components.health:SetInvincible(false)
	-- 		inst.DynamicShadow:Enable(true)
	-- 		DoPortalTint(inst, 0)
	-- 		FullHide(inst)
    --         inst.sg:GoToState("idle")
    --     end,
    -- },

	State{
        name = "fake_portal_jumpin",
		tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt" },
		
		onenter = function(inst)
            local x, y, z = inst.Transform:GetWorldPosition()
			inst.AnimState:PlayAnimation("wortox_portal_jumpin")
            SpawnPrefab("wortox_portal_jumpin_fx").Transform:SetPosition(x,y,z)
		end,

        onupdate = function(inst)
            if inst.sg.statemem.tints ~= nil then
                DoPortalTint(inst, table.remove(inst.sg.statemem.tints))
                if #inst.sg.statemem.tints <= 0 then
                    inst.sg.statemem.tints = nil
                end
            end
        end,

		timeline =
		{ 
			TimeEvent(FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/together/toad_stool/infection_post", nil, .7)
                inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn", nil, .5)
            end),
            TimeEvent(2 * FRAMES, function(inst)
                inst.sg.statemem.tints = { 1, .6, .3, .1 }
            end),
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:AddStateTag("noattack")
                inst.DynamicShadow:Enable(false)
            end),
		},

		events = 
		{
			EventHandler("animover", function(inst)
				inst.components.locomotor:SetExternalSpeedMultiplier(inst, "wortox_power", 0)
				inst.Physics:Stop()
				
                DoPortalTint(inst, 0)
				inst.components.sanity.ignore = true
                local tuning = TUNING.HG.HERO_POWER.WORTOX[1]
                if inst.teleport_count == nil then
                    inst.teleport_count = 0
                end
                inst.teleport_count = inst.teleport_count + 1
                if inst.teleport_count ~= inst.teleport_count_max then
                    local pt = inst.pt or inst:GetPosition()
                    local theta = math.random() * 2 * PI
                    local offset = FindValidPositionByFan(theta, tuning.range, 6, function(offset) 	
                        local x = pt.x + offset.x
                        local z = pt.z + offset.z
                        return TheWorld.Map:IsPassableAtPoint(x, 0, z)
                            and not TheWorld.Map:IsPointNearHole(Vector3(x, 0, z))
                    end) 
                    if offset ~= nil then
                        pt.x = pt.x + offset.x
                        pt.z = pt.z + offset.z
                    end
                    inst.Transform:SetRotation( math.random(0,360))
                    inst.Transform:SetPosition(pt:Get())
                    inst.sg:GoToState("fake_portal_jumpout")
				else
					inst.components.health:SetInvincible(false)
					inst.sg:GoToState("idle")
					FullHide(inst)
					inst.components.sanity.ignore = false
					inst.teleport_count = 0
					inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "wortox_power")
				end
			end),
		},
	},

	State{
        name = "fake_portal_jumpout",
		tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt" },
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("wortox_portal_jumpout")
            local x, y, z = inst.Transform:GetWorldPosition()
            SpawnPrefab("wortox_portal_jumpout_fx").Transform:SetPosition(x, y, z)
		end,

        onupdate = function(inst)
            if inst.sg.statemem.tints ~= nil then
                DoPortalTint(inst, table.remove(inst.sg.statemem.tints))
                if #inst.sg.statemem.tints <= 0 then
                    inst.sg.statemem.tints = nil
                end
            end
        end,

        timeline =
		{ 
            TimeEvent(FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/hop_out") end),
            TimeEvent(5 * FRAMES, function(inst)
                inst.sg.statemem.tints = { 0, .4, .7, .9 }
            end),
            TimeEvent(7 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
            end),
		},

		events = 
		{
			EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("fake_portal_jumpin")
				end
			end),
		},
	},

	State{
        name = "flowerrebirth",
		tags = { "busy", "noattack", "nopredict", "nomorph" },
       
        onenter = function(inst)
            if inst.CustomSetSkinMode ~= nil then
                inst:CustomSetSkinMode(inst.overrideskinmode or "normal_skin")
            else
                inst.AnimState:SetBank("wilson")
                inst.components.skinner:SetSkinMode(inst.overrideskinmode or "normal_skin")
            end
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
                inst.components.playercontroller:Enable(false)
            end
            inst.AnimState:PlayAnimation("rebirth2")
            
            inst.components.hunger:Pause()
            for k,v in pairs(plant_symbols) do
                inst.AnimState:OverrideSymbol(v, "lifeplant", v)
            end
            inst.components.health:SetInvincible(true)
            inst:ShowActions(false)
            inst:SetCameraDistance(14)
        end,

        onexit = function(inst)
            inst:ShowActions(true)
            inst:SetCameraDistance()
            inst.components.bloomer:PopBloom("playerghostbloom")
            inst.AnimState:SetLightOverride(0)
            if inst.sg:HasStateTag("ghostbuild") then
                inst.sg:RemoveStateTag("ghostbuild")
                inst:PushEvent("stopghostbuildinstate")
            end
            inst.components.health:SetInvincible(false)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end

            inst.components.health:SetInvincible(false)
            for k,v in pairs(plant_symbols) do
                inst.AnimState:ClearOverrideSymbol(v)
            end
        
            SerializeUserSession(inst)
        end,        
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },

    }, 
	
	State{
		name = "mutesong",
		tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt" },
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("sing", false)
			inst.components.locomotor:Stop()
		end,

		timeline =
		{ 
			TimeEvent(3 * FRAMES, function(inst)
				local songs = {"durability", "healthgain", "sanitygain", "sanityaura", "fireresistance", "inspirationdamage"}
				inst.SoundEmitter:PlaySound("dontstarve_DLC001/characters/wathgrithr/song/"..songs[math.random(1, #songs)])
			end),

			TimeEvent(24 * FRAMES, function(inst)      
				inst:PerformBufferedAction()
			end),
			TimeEvent(34 * FRAMES, function(inst)      
				inst.sg:RemoveStateTag("busy")
				inst.sg:RemoveStateTag("nopredict")
				inst.sg:RemoveStateTag("nointerrupt")
				inst.sg:RemoveStateTag("nomorph")
				inst.sg:RemoveStateTag("noattack")
			end),
		},

		events = 
		{
			EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},
	},

	State{
        name = "arena_teleport",
        tags = { "busy", "nopredict", "nomorph", "nointerrupt" },

        onenter = function(inst, fn)
            inst.components.locomotor:StopMoving()
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            inst.components.health:SetInvincible(true)
            inst.AnimState:PlayAnimation("teleport", false)
            inst:ShowHUD(false)
            inst:SetCameraDistance(20)

			SpawnAt("hg_arena_teleport_fx", inst)

			if fn then
				inst.sg.statemem.fn = fn
			end
			inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline =
        {
            TimeEvent(0, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_pulled")
            end),
            TimeEvent(35 * FRAMES, function(inst)
				inst.DynamicShadow:Enable(false)
            end),
            TimeEvent(82 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_under")
            end),
        },

		ontimeout = function(inst)
			inst:ScreenFade(false, 0.5)
			if inst.sg.statemem.fn then
				inst.sg.statemem.fn(inst)
			end
		end,

        onexit = function(inst)
            inst:ShowHUD(true)
			inst.DynamicShadow:Enable(true)
            if inst.components.playercontroller then
                inst.components.playercontroller:Enable(true)
            end
            inst.components.health:SetInvincible(false)
        end,
    },
	
	State{
		name = "arena_teleport_bernie",
		tags = { "busy", "nopredict", "nomorph", "nointerrupt" },

		onenter = function(inst, data)
			inst.components.locomotor:StopMoving()
			if inst.components.playercontroller then
				inst.components.playercontroller:Enable(false)
			end
		
			inst.AnimState:PlayAnimation("deactivate")

            inst.Transform:SetNoFaced()

			inst.components.health:SetInvincible(true)

			inst:ShowHUD(false)
			inst:SetCameraDistance(20)
			
			if data then
				inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + (data.timeout or 0))
				inst.sg.statemem.ondone = data.ondone
			end
		end,

		timeline =
		{
			TimeEvent(0, function(inst)
			--	inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_pulled")
			end),
			
			TimeEvent(42 * FRAMES, function(inst)
				SpawnAt("shadow_puff_solid", inst)
				inst.DynamicShadow:Enable(false)
				inst:Hide()
			end),
			
			TimeEvent(54 * FRAMES, function(inst)
				inst:ScreenFade(false, 1)
			end),
		},

		ontimeout = function(inst)
			if inst.sg.statemem.ondone then
				inst.sg.statemem.ondone(inst)
			end
			inst.sg:GoToState("activatebernie")
		end,

		onexit = function(inst)
            inst.Transform:SetFourFaced()
			inst:Show()
			inst.DynamicShadow:Enable(true)
			inst:ShowHUD(true)
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(true)
			end
			inst.components.health:SetInvincible(false)
		end,
	},

	State{
        name = "ghostroom_teleport_in",
        tags = { "busy", "nopredict", "nomorph", "nodangle", "jumping", "noattack" },

        onenter = function(inst, data)
			FullShow(inst)
            inst.components.locomotor:Stop()
			
			local x, y, z = inst.Transform:GetWorldPosition()
			local fx = SpawnPrefab("pocketwatch_portal_exit_fx")
			fx.Transform:SetPosition(x, 0, z)
			fx.AnimState:PlayAnimation("portal_entrance_pre")
			fx.AnimState:PushAnimation("portal_entrance_pst", false)
			fx:ListenForEvent("animqueueover", fx.Remove)

			inst.AnimState:PlayAnimation("jump_pre")
			inst.AnimState:PushAnimation("jump", false)
        end,

        timeline =
        {
            TimeEvent(17 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("wanda1/wanda/jump_whoosh")
            end),

            TimeEvent(20 * FRAMES, function(inst)
                inst.DynamicShadow:Enable(false)
            end),

            TimeEvent(22 * FRAMES, function(inst)
                PlayFootstep(inst)
				inst:ScreenFade(false, .5)
            end),

            TimeEvent(28 * FRAMES, function(inst)
				if inst.components.spectator then
					inst.components.spectator:SetRandomTarget()
				end
                inst.sg:RemoveStateTag("jumping")
                inst.sg:RemoveStateTag("busy")
                inst.sg:RemoveStateTag("nomorph")
				inst.sg:RemoveStateTag("noattack")
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

		onexit = function(inst)
			FullHide(inst)
			inst:DoTaskInTime(2, function()
				inst:PushEvent("ms_becameghost")
				inst:ScreenFade(true, .5)
			end)
		end,
	},


	State{
        name = "ghostroom_teleport_out",
        tags = { "busy", "nopredict", "nomorph", "nodangle", "jumping", "noattack" },

        onenter = function(inst, data)
			FullShow(inst)
            inst.components.locomotor:Stop()
			
			local x, y, z = inst.Transform:GetWorldPosition()
			local fx = SpawnPrefab("pocketwatch_portal_exit_fx")
			fx.Transform:SetPosition(x, 4, z)

			inst.AnimState:PlayAnimation("jumpportal_out")
        end,

        timeline =
        {
            TimeEvent(17 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("wanda1/wanda/jump_whoosh")
            end),

            TimeEvent(20 * FRAMES, function(inst)
                inst.DynamicShadow:Enable(true)
            end),

            TimeEvent(22 * FRAMES, function(inst)
                PlayFootstep(inst)
            end),

            TimeEvent(28 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("jumping")
                inst.sg:RemoveStateTag("busy")
                inst.sg:RemoveStateTag("nomorph")
				inst.sg:RemoveStateTag("noattack")
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

		onexit = function(inst)
            inst:PushEvent("ms_becameghostplayer")
		end,
	},
	-- State{
	-- 	name = "hide",
	-- 	tags = { "hiding", "notalking", "notarget", "nomorph", "busy", "nopredict", "nodangle" },
	
	-- 	onenter = function(inst)
	-- 		inst.components.locomotor:Stop()
	-- 		inst.AnimState:PlayAnimation("hide")
	-- 		inst.AnimState:PushAnimation("hide_idle", false)
			
	-- 		if inst.components.name_displayer then
	-- 			inst.components.name_displayer:HideName("bush")
	-- 		end
			
	-- 		if inst.district_icon then
	-- 			inst.district_icon:Hide()
	-- 		end			
			
	-- 		inst.SoundEmitter:PlaySound("dontstarve/movement/foley/hidebush")
	-- 	end,
	
	-- 	timeline =
	-- 	{
	-- 		TimeEvent(17 * FRAMES, CreateFakeBush),
			
	-- 		TimeEvent(24 * FRAMES, function(inst)
	-- 			inst.sg:RemoveStateTag("busy")
	-- 			inst.sg:RemoveStateTag("nopredict")
	-- 			inst.sg:AddStateTag("idle")
	-- 			FullHide(inst, true)
	-- 		end),
	-- 	},
		
	-- 	events =
	-- 	{
	-- 		EventHandler("unequip", function(inst, data)
	-- 			if not inst.sg:HasStateTag("idle") then
	-- 				inst.sg:GoToState(GetUnequipState(inst, data))
	-- 			end
	-- 		end),
	-- 	},
	
	-- 	onexit = function(inst)
	-- 		FullShow(inst)
	-- 		if inst.sg.statemem.talktask then
	-- 			inst.sg.statemem.talktask:Cancel()
	-- 			inst.sg.statemem.talktask = nil
	-- 			inst.SoundEmitter:KillSound("talk")
	-- 		end
			
	-- 		inst.AnimState:SetErosionParams(0, 0, 0)

	-- 		inst.Physics:SetCollides(true)
	-- 		inst.Physics:SetMass(inst.mass)
			
	-- 		if not TheWorld.Map:IsOceanAtPoint(inst.Transform:GetWorldPosition()) then
	-- 			inst.DynamicShadow:Enable(true)
	-- 		end
		
	-- 		inst.components.talker:StopIgnoringAll("bushhat")
			
	-- 		if CachedBushes[inst.entity] and CachedBushes[inst.entity]:IsValid() then
	-- 			CachedBushes[inst.entity]:Remove()
	-- 		end
			
	-- 		CachedBushes[inst.entity] = nil
			
	-- 		if inst.components.name_displayer then
	-- 			inst.components.name_displayer:ShowName("bush")
	-- 		end

	-- 		if TheWorld.net and not TheWorld.net.components.hg_network:MasksActive() then
	-- 			if inst.district_icon then
	-- 				inst.district_icon:Show()
	-- 			end	
	-- 		end	
	-- 	end,
	-- },

	State{
		name = "longeat",
		tags = { "busy", "nodangle" },

		onenter = function(inst, foodinfo)
			inst.components.locomotor:Stop()

			local feed = foodinfo and foodinfo.feed
			if feed ~= nil then
				inst.components.locomotor:Clear()
				inst:ClearBufferedAction()
				inst.sg.statemem.feed = foodinfo.feed
				inst.sg.statemem.feeder = foodinfo.feeder
				inst.sg:AddStateTag("pausepredict")
				if inst.components.playercontroller ~= nil then
					inst.components.playercontroller:RemotePausePrediction()
				end
			elseif inst:GetBufferedAction() then
				feed = inst:GetBufferedAction().invobject
			end

			if feed == nil or
				feed.components.edible == nil or
				feed.components.edible.foodtype ~= FOODTYPE.GEARS then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/eat", "eating")
			end

			if inst.components.inventory:IsHeavyLifting() and
				not inst.components.rider:IsRiding() then
				inst.AnimState:PlayAnimation("heavy_eat")
			else
				inst.AnimState:PlayAnimation("eat_pre")
				inst.AnimState:PushAnimation("eat", false)
			end

			inst.components.hunger:Pause()
		end,

		timeline =
		{
			TimeEvent(45 * FRAMES, function(inst)
				if inst.sg.statemem.feed ~= nil then
					inst.components.eater:Eat(inst.sg.statemem.feed, inst.sg.statemem.feeder)
				else
					inst:PerformBufferedAction()
				end
			end),

			TimeEvent(55 * FRAMES, function(inst)
				inst.sg:RemoveStateTag("busy")
				inst.sg:RemoveStateTag("pausepredict")
			end),

			TimeEvent(70 * FRAMES, function(inst)
				inst.SoundEmitter:KillSound("eating")
			end),
		},

		events =
		{
			EventHandler("animqueueover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},

		onexit = function(inst)
			inst.SoundEmitter:KillSound("eating")
			if not GetGameModeProperty("no_hunger") then
				inst.components.hunger:Resume()
			end
			if inst.sg.statemem.feed ~= nil and inst.sg.statemem.feed:IsValid() then
				inst.sg.statemem.feed:Remove()
			end
		end,
	},
	
	State{
		name = "blowdart_long",
		tags = { "attack", "notalking", "abouttoattack", "autopredict" },

		onenter = function(inst)
			local buffaction = inst:GetBufferedAction()
			local target = buffaction ~= nil and buffaction.target or nil
			local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			inst.components.combat:SetTarget(target)
			inst.components.combat:StartAttack()
			inst.components.locomotor:Stop()
			inst.AnimState:PlayAnimation("dart_pre")
			inst.AnimState:SetDeltaTimeMultiplier(BLOWDART_SPEED)
			if inst.sg.prevstate == inst.sg.currentstate then
				inst.sg.statemem.chained = true
				inst.AnimState:SetTime(5 * FRAMES)
			end
			inst.AnimState:PushAnimation("dart", false)

			inst.sg:SetTimeout(math.max((inst.sg.statemem.chained and 14 or 18) * FRAMES, inst.components.combat.min_attack_period + .5 * FRAMES) * 2)

			if target ~= nil and target:IsValid() then
				inst:FacePoint(target.Transform:GetWorldPosition())
				inst.sg.statemem.attacktarget = target
			end

			if (equip ~= nil and equip.projectiledelay or 0) > 0 then
				--V2C: Projectiles don't show in the initial delayed frames so that
				--     when they do appear, they're already in front of the player.
				--     Start the attack early to keep animation in sync.
				inst.sg.statemem.projectiledelay = (inst.sg.statemem.chained and 9 or 14) * FRAMES - equip.projectiledelay
				if inst.sg.statemem.projectiledelay <= 0 then
					inst.sg.statemem.projectiledelay = nil
				end
			end
		end,

		onupdate = function(inst, dt)
			if (inst.sg.statemem.projectiledelay or 0) > 0 then
				inst.sg.statemem.projectiledelay = inst.sg.statemem.projectiledelay - dt
				if inst.sg.statemem.projectiledelay <= 0 then
					inst:PerformBufferedAction()
					inst.sg:RemoveStateTag("abouttoattack")
				end
			end
		end,

		timeline =
		{
			TimeEvent(8 * FRAMES * (2 - BLOWDART_SPEED), function(inst)
				if inst.sg.statemem.chained then
					inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
				end
			end),
			TimeEvent(9 * FRAMES * (2 - BLOWDART_SPEED), function(inst)
				if inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
					inst:PerformBufferedAction()
					inst.sg:RemoveStateTag("abouttoattack")
				end
			end),
			TimeEvent(13 * FRAMES * (2 - BLOWDART_SPEED), function(inst)
				if not inst.sg.statemem.chained then
					inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
				end
			end),
			TimeEvent(14 * FRAMES * (2 - BLOWDART_SPEED), function(inst)
				if not inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
					inst:PerformBufferedAction()
					inst.sg:RemoveStateTag("abouttoattack")
				end
			end),
		},

		ontimeout = function(inst)
			inst.sg:RemoveStateTag("attack")
			inst.sg:AddStateTag("idle")
		end,

		events =
		{
			EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
			EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
			EventHandler("animqueueover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},

		onexit = function(inst)
			inst.AnimState:SetDeltaTimeMultiplier(1)
			inst.components.combat:SetTarget(nil)
			if inst.sg:HasStateTag("abouttoattack") then
				inst.components.combat:CancelAttack()
			end
		end,
	},
	
	State{
		name = "hg_spawn",
		tags = { "busy", "nopredict", "nomorph", "nodangle", "nointerrupt" },

		onenter = function(inst, fn)
			inst.AnimState:PlayAnimation("enter")
			
			if inst.components.health then
				inst.components.health:SetInvincible(true)
			end
			
			inst.sg.statemem.ondone = fn
			inst.sg.statemem.voicevolume = .25
		end,
		
		onupdate = function(inst, dt)
			if not inst.SoundEmitter:PlayingSound("player_hurt") or inst.sg.statemem.voicevolume == 1 then
				return
			end
			inst.sg.statemem.voicevolume = math.min(inst.sg.statemem.voicevolume + dt * 3.5, 1)
			inst.SoundEmitter:SetVolume("player_hurt", inst.sg.statemem.voicevolume)
		end,
		
		timeline =
		{
			TimeEvent(5 * FRAMES, function(inst)
				DoHurtSound(inst)
				inst.SoundEmitter:SetVolume("player_hurt", inst.sg.statemem.voicevolume)
			end),
			
			TimeEvent(11 * FRAMES, function(inst)
				inst.SoundEmitter:KillSound("player_hurt")
				inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
			end),
		},

		events =
		{
			EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},
		
		onexit = function(inst)
			if inst.components.health then
				inst.components.health:SetInvincible(false)
			end
			
			if inst.sg.statemem.ondone then
				inst.sg.statemem.ondone(inst)
			end
		end,
	},
	
	State{
		name = "wortox_use_power",
		tags = { "busy", "nopredict", "nomorph", "nodangle", "nointerrupt" },

		onenter = function(inst, fn)
			inst.components.locomotor:Stop()
			
			if inst.components.playercontroller then
				inst.components.playercontroller:Enable(false)
			end
			
			-- 18 FRAMES

			if inst.components.rider:IsRiding() then
				inst.AnimState:PlayAnimation("emote_fistshake", false)
			else
				inst.AnimState:PlayAnimation("teleport_out", false)
				inst.AnimState:PushAnimation("give_pst", false)
            end
			inst.sg.statemem.fn = fn
			
			if not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
				inst.AnimState:ClearOverrideSymbol("swap_object")
				inst.AnimState:Show("ARM_carry")
				inst.AnimState:Hide("ARM_normal")
			end
		end,
		
		timeline =
		{
			TimeEvent(8 * FRAMES, function(inst)
				-- do fx here
				SpawnAt("wortox_use_power", inst:GetPosition() + Vector3(0, 6, 0))
				
				if inst.sg.statemem.fn then
					inst.sg.statemem.fn(inst)
				end
			end),
			
			TimeEvent(18 * FRAMES, function(inst)
				if not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
					inst.AnimState:Hide("ARM_carry")
					inst.AnimState:Show("ARM_normal")
				end
			end),
		},

		events =
		{
			EventHandler("animqueueover", function(inst)
				if inst.AnimState:AnimDone() then
					-- TODO: Add pst anim
					inst.sg:GoToState("idle")
				end
			end),
		},
		
		onexit = function(inst)
			if inst.components.playercontroller then
				inst.components.playercontroller:Enable(true)
			end
			
			if not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
				inst.AnimState:Hide("ARM_carry")
				inst.AnimState:Show("ARM_normal")
			end
		end,
	},

	State{
		name = "willow_use_power",
		tags = { "busy", "nopredict", "nomorph", "nodangle", "nointerrupt" },

		onenter = function(inst)
			inst.components.locomotor:Stop()
			inst.Physics:Stop()

			if inst.components.playercontroller then
				inst.components.playercontroller:Enable(false)
			end
			
            inst.AnimState:PlayAnimation("powerup")
		end,
		
		timeline =
		{
			TimeEvent(8 * FRAMES, function(inst)
				SpawnAt("tauntfire_fx", inst:GetPosition())
				SpawnAt("firesplash_fx", inst:GetPosition())
			end),
		},

		events =
		{
			EventHandler("animqueueover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},
		
		onexit = function(inst)
			if inst.components.playercontroller then
				inst.components.playercontroller:Enable(true)
			end
		end,
	},

	State{
		name = "apply_mask",
		tags = { "busy", "nopredict", "nomorph", "nodangle", "nointerrupt" },

		onenter = function(inst, fn)
			inst.components.locomotor:Stop()
			
			if inst.components.playercontroller then
				inst.components.playercontroller:Enable(false)
                inst.components.playercontroller:RemotePausePrediction()
			end
			
            inst.AnimState:OverrideSymbol("shadow_hands", "shadow_skinchangefx", "shadow_hands")
            inst.AnimState:OverrideSymbol("shadow_ball", "shadow_skinchangefx", "shadow_ball")
            inst.AnimState:OverrideSymbol("splode", "shadow_skinchangefx", "splode")

            inst.AnimState:PlayAnimation("skin_change", false)

			inst.SoundEmitter:PlaySound("dontstarve/common/together/skin_change")

			inst:SetCameraZoomed(true)
			inst:ShowHUD(false)

			inst.sg.statemem.fn = fn
		end,
		
		timeline =
		{
			TimeEvent(42 * FRAMES, function(inst)
				if not inst.components.health:IsDead() then
					if inst.sg.statemem.fn then
						inst.sg.statemem.fn(inst)
					elseif inst.components.debuffable then
						inst.components.debuffable:AddDebuff("debuff_masks", "debuff_masks")
					end
				end
            end),
		},

		events =
		{
			EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},

		onexit = function(inst)
            inst.AnimState:OverrideSymbol("shadow_hands", "shadow_hands", "shadow_hands")

			inst:SetCameraZoomed(false)
			inst:ShowHUD(true)

			if inst.components.playercontroller then
				inst.components.playercontroller:Enable(true)
			end
		end,
	},

	State{
		name = "wes_cycle_pre",
		tags = { "busy", "nopredict", "nomorph", "nodangle", "cycling" },

		onenter = function(inst, fn)
			inst.components.locomotor:Stop()
			
			if not inst.sg.mem.twofaced then
				inst.Transform:SetTwoFaced()
			end

			inst.sg.mem.twofaced = true

			inst.AnimState:PlayAnimation("mime8", false)
		end,
		
		timeline =
		{
			TimeEvent(4 * FRAMES, function(inst)
				inst.sg.mem.savefacing = true
				inst.sg:GoToState("wes_cycle_loop")
			end),
		},

		onexit = function(inst)
			if not inst.sg.mem.savefacing then
				inst.sg.mem.twofaced = nil
				inst.Transform:SetFourFaced()
			else
				inst.sg.mem.savefacing = nil
			end
		end,
	},

	State{
		name = "wes_cycle_loop",
		tags = { "nopredict", "nomorph", "nodangle", "cycling" },

		onenter = function(inst, fn)
			inst.AnimState:PlayAnimation("mime8", false)
			inst.AnimState:SetTime(4 * FRAMES)

			if not inst.sg.mem.twofaced then
				inst.Transform:SetTwoFaced()
			end
		end,
		
		timeline =
		{
			TimeEvent((51 - 4) * FRAMES, function(inst)
				inst.sg.mem.savefacing = true
				inst.sg:GoToState("wes_cycle_loop")
			end),
		},

		onexit = function(inst)
			if not inst.sg.mem.savefacing then
				inst.sg.mem.twofaced = nil
				inst.Transform:SetFourFaced()
			else
				inst.sg.mem.savefacing = nil
			end
		end,
	},

	State{
		name = "wes_cycle_pst",
		tags = { "busy", "nopredict", "nomorph", "nodangle" },

		onenter = function(inst, fn)
			inst.components.locomotor:Stop()
			
			inst.AnimState:PlayAnimation("mime8", false)
			inst.AnimState:SetTime(52 * FRAMES)

			if not inst.sg.mem.twofaced then
				inst.Transform:SetTwoFaced()
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

		onexit = function(inst)
			inst.sg.mem.twofaced = nil
			inst.sg.mem.savefacing = nil
			inst.Transform:SetFourFaced()
		end,
	},

	State{
        name = "skill_checking",
        tags = { "doing", "nodangle", },

        onenter = function(inst, timeout)
            inst.sg:SetTimeout(1)
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")
            inst.AnimState:PlayAnimation("build_pre", false)

			if inst.bufferedaction then
                inst.sg.statemem.action = inst.bufferedaction
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
					inst:PerformBufferedAction()
                    inst.sg:GoToState("skill_checking_loop")
                end
            end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("make")

			if inst.bufferedaction == inst.sg.statemem.action and
            (not inst.components.playercontroller or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

	State{
        name = "skill_checking_loop",
        tags = { "doing", "nodangle", "skill_checking" },

        onenter = function(inst, timeout)
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")
            inst.AnimState:PushAnimation("build_loop", true)
        end,

        events =
        {
            EventHandler("skill_checked", function(inst)
                inst.AnimState:PlayAnimation("build_pre")
                inst.AnimState:SetTime(4.5 * FRAMES)
            	inst.AnimState:PushAnimation("build_loop", true)
            end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("make")
        end,
    },

    State{
        name = "sneeze",
        tags = {"busy","sneeze"},
        
        onenter = function(inst)
            if inst.components.rider:IsRiding() then
                inst.Transform:SetFourFaced()
            end
            inst.wantstosneeze = false
            inst.SoundEmitter:PlaySound("dontstarve/wilson/hit",nil,.02)
            inst.AnimState:PlayAnimation("sneeze")
            inst.SoundEmitter:PlaySound("HG_sounds/characters/sneeze")
            inst:ClearBufferedAction()
            
            if inst.prefab ~= "wes" then
                local sound_name = inst.soundsname or inst.prefab
                local path = inst.talker_path_override or "dontstarve/characters/"

                local sound_event = path..sound_name.."/hurt"
                inst.SoundEmitter:PlaySound(inst.hurtsoundoverride or sound_event)
            end
            inst.components.locomotor:Stop()  

            inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_SNEEZE"))        
        end,

        onexit = function(inst)
            if inst.components.rider:IsRiding() then
                inst.Transform:SetSixFaced()
            end
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        }, 
        
        timeline =
        {
            TimeEvent(10*FRAMES, function(inst)
                if inst.components.hayfever then
                    inst.components.hayfever:DoSneezeEffects()
                end
                inst.sg:RemoveStateTag("busy")
            end),
        },                 
    },

	State{
        name = "fossilize",
        tags = { "busy", "nopredict", "nomorph", "nodangle", "nointerrupt"},

        onenter = function(inst, timeout)
			inst.sg:SetTimeout(TUNING.HG.FOSSILIZIATION.TIME)
			if not inst._fossilizefx then
				inst.components.locomotor:Stop()
            	inst._fossilizefx = inst:SpawnChild("hg_fossilized_fx")
				inst._fossilizefx:Fossilize(inst)
				inst.SoundEmitter:SetMute(true)
				inst.AnimState:PlayAnimation("hit")
				ListenForAttacks(inst, TUNING.HG.FOSSILIZIATION.HITSTOUNBLOCK, function() end)
				inst:ListenForEvent("death", UnFossilize)
				SpawnAt("fossilizing_fx", inst)
			end
		end,
		
		timeline =
		{
			TimeEvent(4 * FRAMES, function(inst)
				inst.AnimState:Pause()
			end),
		},

        ontimeout = function(inst)
			UnFossilize(inst)
			inst:RemoveEventCallback("attacked", OnAttackFossilized)
        end,
    },

	State
    {
        name = "dodge",
        tags = {"busy", "evade", "no_stun", "canrotate", "nopredict"},

        onenter = function(inst, data)
			inst.components.locomotor:Stop()

			inst.sg.statemem.pos = data.pos:GetPosition()
			inst:ForceFacePoint(inst.sg.statemem.pos.x, 0, inst.sg.statemem.pos.z)
            
			if inst.predodge then
				inst.predodge(inst)
			end

            inst.was_invincible = inst.components.health.invincible
            inst.components.health:SetInvincible(true)
            inst.sg:AddStateTag("noattack")
            
            inst.last_dodge_time = GetTime()
			inst.dodgetime:set(inst.dodgetime:value() == false and true or false)
			
			if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
				inst.components.playercontroller:Enable(false)
            end

			inst.sg:SetTimeout(0.9)
        end,

		ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,

        onexit = function(inst)
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()
            inst.components.locomotor:Stop()
            inst.components.locomotor:SetBufferedAction(nil)

            if not inst.was_invincible then
                inst.components.health:SetInvincible(false)
            end

			if inst.components.playercontroller then
				inst.components.playercontroller:Enable(true)
			end

			if inst.ondodge then
				inst.ondodge(inst)
			end

            inst.sg:RemoveStateTag("noattack")
            inst.was_invincible = nil
        end,

		timeline =
        {        
            TimeEvent(FRAMES, function(inst)
				local pos1 = inst:GetPosition()
				local pos2 = inst.sg.statemem.pos
				local distsq = distsq(pos1.x, pos1.z, pos2.x, pos2.z)
				local dist =  math.min(13, math.ceil(math.sqrt(distsq))) + 0.2

				inst.AnimState:PlayAnimation("dodgeroll")
				inst.SoundEmitter:PlaySound("HG_sounds/characters/wheeler/slide")
				inst.Physics:SetMotorVelOverride(dist, 0, 0)
				inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            end),
        },
    },

}

-- local wilbur_states = require("stategraphs/SGwilbur")
-- for _, state in ipairs(wilbur_states) do
-- 	table.insert(STATES, state)
-- end

return STATES
