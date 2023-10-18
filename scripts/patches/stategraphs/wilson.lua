return function(self)
	-- Applying action speed mod
	local _dolongaction = self.states.dolongaction.onenter
	self.states.dolongaction.onenter = function(inst, timeout)
		_dolongaction(inst, timeout)
		if (not timeout or timeout <= 1) and inst.components.action_speed then
			timeout = (timeout or 1) * inst.components.action_speed:Get()
			inst.sg:SetTimeout(timeout)
		end
	end

	local _dolongaction_exit = self.states.dolongaction.onexit
	self.states.dolongaction.onexit = function(inst)
		if inst:HasTag("hungrybuilder") and inst.components.action_speed:Get() < 1 then
			_dolongaction_exit(inst)
			inst.components.hunger:DoDelta(TUNING.HUNGRY_BUILDER_DELTA)
			inst:PushEvent("hungrybuild")
		end
	end

	-- Winona patch
	self.states.dohungrybuild.onenter = function(inst) inst.sg:GoToState("dolongaction") end

	-- Wortox server-side test
	local _portal_jumpin_pre = self.states.portal_jumpin_pre.onenter
	self.states.portal_jumpin_pre.onenter = function(inst, ...)
		if not inst.components.sanity or inst.components.sanity.current < TUNING.WORTOX_TELEPORT_SANITY then
			if inst.components.talker then
				inst.components.talker:Say(GetString(inst, "ANNOUNCE_NOSANITY"))
			end
			return false
		end
		return _portal_jumpin_pre(inst, ...)
	end

	local _death = self.states.death.onenter
	self.states.death.onenter = function(inst, ...)
		if inst.lifeplant then
			inst.lifeplant:Save()
		end
		return _death(inst, ...)
	end

	local _Eat = self.actionhandlers[ACTIONS.EAT].deststate
	self.actionhandlers[ACTIONS.EAT].deststate = function(inst, action, ...)
		local val = _Eat(inst, action, ...)
		local obj = action.target or action.invobject
		
		if obj and obj:HasTag("chewable") then
			return "longeat"
		end
		return val
	end
	
	local _Attack = self.actionhandlers[ACTIONS.ATTACK].deststate
	self.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action, ...)
		local val = _Attack(inst, action, ...)
		-- print(inst.sg:HasStateTag("attack"), action.target == inst.sg.statemem.attacktarget)
		if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.components.health:IsDead()) then
			local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
			if weapon and weapon.prefab == "blowdart_sleep" then
				return "blowdart_long"
			end
		end
		
		return val
	end

	-- local _CastAoe = self.actionhandlers[ACTIONS.CASTAOE].deststate
	-- self.actionhandlers[ACTIONS.CASTAOE].deststate = function(inst, action, ...)
	-- 	local val = _CastAoe(inst, action, ...)
	-- 	local invobject = action.invobject
	-- 	if invobject and invobject:HasTag("wickerbottom_book") then
	-- 		inst.components.sanity:DoDelta(TUNING.HG.BOOKS.SPELLCOST)
	-- 		invobject.components.rechargeable:Discharge(invobject.cooldown)
	-- 	end
	-- 	return val
	-- end

	-- local _Read = self.actionhandlers[ACTIONS.READ].deststate
	-- self.actionhandlers[ACTIONS.READ].deststate = function(inst, action, ...)
	-- 	local val = _Read(inst, action, ...)
	-- 	local invobject = action.invobject
	-- 	if invobject and invobject:HasTag("wickerbottom_book") then
	-- 		invobject.components.rechargeable:Discharge(invobject.cooldown)
	-- 	end
	-- 	return val
	-- end
	
	local _attacked = self.events.attacked.fn
	self.events.attacked.fn = function(inst, data)
		if not inst.components.health:IsDead() and data and data.stimuli == "wind" then
			inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
			if inst.hurtsoundoverride ~= nil then
				inst.SoundEmitter:PlaySound(inst.hurtsoundoverride, nil, inst.hurtsoundvolume)
			elseif not inst:HasTag("mime") then
				inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/hurt", nil, inst.hurtsoundvolume)
			end
			if inst.sg:HasStateTag("sleeping") then
				if inst.sleepingbag ~= nil then
					inst.sleepingbag.components.sleepingbag:DoWakeUp()
					inst.sleepingbag = nil
				else
					inst.sg.statemem.iswaking = true
					inst.sg:GoToState("hit")
				end
				if inst.components.grue ~= nil then
					inst.components.grue:RemoveImmunity("sleeping")
				end
				if inst.components.talker ~= nil then
					inst.components.talker:StopIgnoringAll("sleeping")
				end
				if inst.components.firebug ~= nil then
					inst.components.firebug:Enable()
				end
				if inst.components.playercontroller ~= nil then
					inst.components.playercontroller:EnableMapControls(true)
					inst.components.playercontroller:Enable(true)
				end
				inst:OnWakeUp()
				inst.components.inventory:Show()
				inst:ShowActions(true)
			end
			return
		end
		inst.sg.mem.sleepimmunity = false
		return _attacked(inst, data)
	end

	local _locomote = self.events.locomote.fn
	self.events.locomote.fn = function(inst, data)
		if inst.components.locomotor:WantsToMoveForward() and
		(inst.components.cycler and inst.components.cycler:IsActive()) then
			inst.components.cycler:Stop()
			return true	
		-- elseif inst:HasTag("monkey") and inst.components.runner:IsRunning() then
		-- 	return MonkeyLocomote(inst, _locomote, data)
		end
		return _locomote(inst, data)
	end
	
	-- Неуязвим пока прыгает
	local _powerup = self.states.powerup.onenter
	self.states.powerup.onenter = function(inst, ...)
		if inst.components.health then
			inst.components.health:SetInvincible(true)
		end
		return _powerup(inst, ...)
	end
	self.states.powerup.onexit = function(inst, ...)
		if inst.components.health then
			inst.components.health:SetInvincible(false)
		end
	end
	
	-- Ignore wakeup state if we were teleported
	local _forcetele = self.states.forcetele.onenter
	self.states.forcetele.onenter = function(inst, ...)
		inst.sg.mem.ignorewakeup = true
		return _forcetele(inst, ...)
	end
	
	local _wakeup = self.states.wakeup.onenter
	self.states.wakeup.onenter = function(inst, ...)
		if inst.sg.mem.ignorewakeup then
			inst.sg.mem.ignorewakeup = nil
			inst.sg:GoToState("idle")
			return
		end
		inst.sg.mem.sleepimmunity = true
		return _wakeup(inst, ...)
	end
	if not self.states.wakeup.timeline then
		self.states.wakeup.timeline = {}
	end
	
	-- Remove the stun after 1.5 seconds
	table.insert(self.states.wakeup.timeline,
		TimeEvent(50 * FRAMES, function(inst)
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(true)
			end
		end)
	)
	
	table.insert(self.states.wakeup.timeline,
		TimeEvent(80 * FRAMES, function(inst)
			inst.sg:RemoveStateTag("waking")
			inst.sg:RemoveStateTag("busy")
			inst.sg:RemoveStateTag("nomorph")
			inst.sg.mem.sleepimmunity = false
		end)
	)

	if self.states.slingshot_shoot.timeline then
		self.states.slingshot_shoot.timeline = {
            TimeEvent(16 * FRAMES, function(inst) -- start of slingshot
				if inst.sg.statemem.chained then
	                inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/stretch")
				end
            end),
            TimeEvent(22 * FRAMES, function(inst)
				if inst.sg.statemem.chained then
					local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
					if equip ~= nil and equip.components.weapon ~= nil and equip.components.weapon.projectile ~= nil then
						inst:PerformBufferedAction()
						inst.sg:RemoveStateTag("abouttoattack")
						inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/shoot")
					else -- out of ammo
						inst:ClearBufferedAction()
						inst.components.talker:Say(GetString(inst, "ANNOUNCE_SLINGHSOT_OUT_OF_AMMO"))
						inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/no_ammo")
						inst.sg:GoToState("idle")
					end
				end
            end),

            TimeEvent(19 * FRAMES, function(inst) -- start of slingshot
				if not inst.sg.statemem.chained then
	                inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/stretch")
				end
            end),
            TimeEvent(25 * FRAMES, function(inst)
				if not inst.sg.statemem.chained then
					local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
					if equip ~= nil and equip.components.weapon ~= nil and equip.components.weapon.projectile ~= nil then
						inst:PerformBufferedAction()
						inst.sg:RemoveStateTag("abouttoattack")
						inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/shoot")
					else -- out of ammo
						inst:ClearBufferedAction()
						inst.components.talker:Say(GetString(inst, "ANNOUNCE_SLINGHSOT_OUT_OF_AMMO"))
						inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/no_ammo")
						inst.sg:GoToState("idle")
					end
				end
            end),
		}
	end

	if self.states.slingshot_shoot.onenter and self.states.slingshot_shoot.onexit then
		local onenter = self.states.slingshot_shoot.onenter
		self.states.slingshot_shoot.onenter = function(inst)
			inst.AnimState:SetDeltaTimeMultiplier(1.2)
			onenter(inst)
		end

		local onexit = self.states.slingshot_shoot.onexit
		self.states.slingshot_shoot.onexit = function(inst)
			inst.AnimState:SetDeltaTimeMultiplier(1)
			onexit(inst)
		end
	end
end
