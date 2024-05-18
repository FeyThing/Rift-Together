return Class(function(self, inst)
	self.inst = inst
	
	local BUSYTHEMES = {
		RT_BIOMES = 1,
		OTHER = 2,
	}
	
	local TRIGGERED_DANGER_MUSIC ={}
	
	local _iscave = inst:HasTag("cave")
	local _isenabled = true
	local _busytask = nil
	local _dangertask = nil
	local _triggeredlevel = nil
	local _isday = nil
	local _isbusydirty = nil
	local _busytheme = nil
	local _extendtime = nil
	local _soundemitter = nil
	local _activatedplayer = nil
	local _hasinspirationbuff = nil
	
	local function IsOnTorren(player)
		return player.components.areaaware ~= nil
		and player.components.areaaware:CurrentlyInTag("torrenarea")
	end
	
	local function StopBusy(inst, istimeout)
		if _busytask ~= nil then
			if not istimeout then
				_busytask:Cancel()
			elseif _extendtime > 0 then
				local time = GetTime()
				if time < _extendtime then
					_busytask = inst:DoTaskInTime(_extendtime - time, StopBusy, true)
					_extendtime = 0
					return
				end
			end
			_busytask = nil
			_extendtime = 0
			_soundemitter:SetParameter("rt_busy", "intensity", 0)
			_soundemitter:SetParameter("busy", "intensity", 0)
		end
	end
	
	local function StartBusy(player)
		if not (_iscave or _isday) then		
			return
		elseif _busytask ~= nil then
			_extendtime = GetTime() + 15
		elseif _dangertask == nil and (_extendtime == 0 or GetTime() >= _extendtime) and _isenabled then
			if not _iscave then
				if IsOnTorren(player) then
					if _busytheme ~= BUSYTHEMES.RT_BIOMES then
						_soundemitter:KillSound("rt_busy")
						_soundemitter:PlaySound("rt_music/music/working_rifts_and_machines", "rt_busy")
					end
					_busytheme = BUSYTHEMES.RT_BIOMES
					_soundemitter:SetParameter("rt_busy", "intensity", 1)
					inst:DoTaskInTime(0.3, function() _soundemitter:SetParameter("busy", "intensity", 0) end)
				else
					_soundemitter:SetParameter("rt_busy", "intensity", 0)
					_soundemitter:SetParameter("busy", "intensity", 1)
					_busytheme = BUSYTHEMES.OTHER
				end
			end
			_busytask = inst:DoTaskInTime(15, StopBusy, true)
			_extendtime = 0
		end
	end
	
	local function ExtendBusy(player)
		if _busytask ~= nil and IsOnTorren(player) then
			_extendtime = math.max(_extendtime, GetTime() + 10)
		end
	end
	
	local function StopDanger(inst, istimeout)
		if _dangertask ~= nil then
			if not istimeout then
				_dangertask:Cancel()
			elseif _extendtime > 0 then
				local time = GetTime()
				if time < _extendtime then
					_dangertask = inst:DoTaskInTime(_extendtime - time, StopDanger, true)
					_extendtime = 0
					return
				end
			end
			_dangertask = nil
			_triggeredlevel = nil
			_extendtime = 0
			_soundemitter:KillSound("danger")
			_soundemitter:KillSound("rt_busy")
		end
	end
	
	local function StartDanger(player)
		if _dangertask ~= nil then
			_extendtime = GetTime() + 10
		elseif _isenabled then
			StopBusy()
			_dangertask = inst:DoTaskInTime(10, StopDanger, true)
			_extendtime = 0
		end
		if _hasinspirationbuff then
			_soundemitter:SetParameter("rt_busy", "wathgrithr_intensity", _hasinspirationbuff)
		end
	end
	
	local function StartTriggeredDanger(player, data)
		local level = math.max(1, math.floor(data ~= nil and data.level or 1))
		if _triggeredlevel == level then
			_extendtime = math.max(_extendtime, GetTime() + (data.duration or 10))
		elseif _isenabled then
			StopBusy()
			StopDanger()
			local music = data ~= nil and TRIGGERED_DANGER_MUSIC[data.name]
			if music ~= nil then
				music = music[level] or music[1]
				if #music > 0 then
					_soundemitter:KillSound("rt_busy")
					_soundemitter:PlaySound(music, "rt_busy")
					inst:DoTaskInTime(0.1, function() _soundemitter:KillSound("danger") end)
					if _hasinspirationbuff then
						_soundemitter:SetParameter("rt_busy", "wathgrithr_intensity", _hasinspirationbuff)
					end
				end
				_dangertask = inst:DoTaskInTime(data.duration or 10, StopDanger, true)
				_triggeredlevel = level
				_extendtime = 0
			end
		end
	end
	
	local function CheckAction(player)
		if player:HasTag("attack") then
			local target = player.replica.combat:GetTarget()
			if target ~= nil and target:HasTag("_combat") then
				StartDanger(player)
				return
			end
		end
		
		if player:HasTag("working") then
			StartBusy(player)
		end
	end
	
	local function OnAttacked(player, data)
		if data ~= nil and
			(data.isattackedbydanger == true or
			(data.attacker ~= nil)) then
			StartDanger(player)
		end
	end
	
	local function OnHasInspirationBuff(player, data)
		_hasinspirationbuff = (data ~= nil and data.on) and 1 or 0
		_soundemitter:SetParameter("danger", "wathgrithr_intensity", _hasinspirationbuff)
	end
	
	local function StartPlayerListeners(player)
		inst:ListenForEvent("buildsuccess", StartBusy, player)
		inst:ListenForEvent("gotnewitem", ExtendBusy, player)
		inst:ListenForEvent("performaction", CheckAction, player)
		inst:ListenForEvent("attacked", OnAttacked, player)
		inst:ListenForEvent("triggeredevent", StartTriggeredDanger, player)
		inst:ListenForEvent("hasinspirationbuff", OnHasInspirationBuff, player)
	end
	
	local function StopPlayerListeners(player)
		inst:RemoveEventCallback("buildsuccess", StartBusy, player)
		inst:RemoveEventCallback("gotnewitem", ExtendBusy, player)
		inst:RemoveEventCallback("performaction", CheckAction, player)
		inst:RemoveEventCallback("attacked", OnAttacked, player)
		inst:RemoveEventCallback("triggeredevent", StartTriggeredDanger, player)
		inst:RemoveEventCallback("hasinspirationbuff", OnHasInspirationBuff, player)
	end
	
	local function OnPhase(inst, phase)
		_isday = phase == "day"
		if _dangertask ~= nil or not _isenabled then
			return
		end
		local time
		if _busytask == nil and _extendtime ~= 0 then
			time = GetTime()
			if time < _extendtime then
				return
			end
		end
		StopBusy()
		_extendtime = (time or GetTime()) + 15
	end
	
	local function StartSoundEmitter()
		if _soundemitter == nil then
			_soundemitter = TheFocalPoint.SoundEmitter
			_extendtime = 0
			_isbusydirty = true
			if not _iscave then
				_isday = inst.state.isday
				inst:WatchWorldState("phase", OnPhase)
			end
		end
	end
	
	local function StopSoundEmitter()
		if _soundemitter ~= nil then
			StopDanger()
			StopBusy()
			_soundemitter:KillSound("rt_busy")
			_soundemitter:KillSound("busy")
			inst:StopWatchingWorldState("phase", OnPhase)
			_isday = nil
			_busytheme = nil
			_isbusydirty = nil
			_extendtime = nil
			_soundemitter = nil
			_hasinspirationbuff = nil
		end
	end
	
	local function OnPlayerActivated(inst, player)
		if _activatedplayer == player then
			return
		elseif _activatedplayer ~= nil and _activatedplayer.entity:IsValid() then
			StopPlayerListeners(_activatedplayer)
		end
		_activatedplayer = player
		StopSoundEmitter()
		StartSoundEmitter()
		StartPlayerListeners(player)
	end
	
	local function OnPlayerDeactivated(inst, player)
		StopPlayerListeners(player)
		if player == _activatedplayer then
			_activatedplayer = nil
			StopSoundEmitter()
		end
	end
	
	local function OnEnableDynamicMusic(inst, enable)
		if _isenabled ~= enable then
			if not enable and _soundemitter ~= nil then
				StopDanger()
				StopBusy()
				_soundemitter:KillSound("rt_busy")
				_soundemitter:KillSound("busy")
				_isbusydirty = true
			end
			_isenabled = enable
		end
	end
	
	inst:ListenForEvent("playeractivated", OnPlayerActivated)
	inst:ListenForEvent("playerdeactivated", OnPlayerDeactivated)
	inst:ListenForEvent("enabledynamicmusic", OnEnableDynamicMusic)
end)