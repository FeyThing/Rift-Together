local function KnockbackOther(inst, data)
	if data ~= nil and data.target ~= nil then
		data.target:PushEvent("knockback", {knocker = inst, radius = 5, strengthmult = 1, forcelanded = false})
	end
end

local function KnightAttach(inst, target)
	if target.components.combat ~= nil then
		target.components.combat.externaldamagemultipliers:SetModifier(inst, TUNING.RT_PAWN_BUFF_KNIGHT_ATTACK_MULT, "rt_pawn_buff_knight")
		
		target:ListenForEvent("onattackother", KnockbackOther)
	end
end

local function KnightDetach(inst, target)
	if target.components.combat ~= nil then
		target.components.combat.externaldamagemultipliers:RemoveModifier(inst, "rt_pawn_buff_knight")
		
		target:RemoveEventCallback("onattackother", KnockbackOther)
	end
end

local function BishopAttach(inst, target)
	if target.components.combat ~= nil then
		target.components.combat:SetAttackPeriod(TUNING.RT_PAWN_BUFF_BISHOP_ATTACK_PERIOD)
	end
end

local function BishopDetach(inst, target)
	if target.components.combat ~= nil then
		target.components.combat:SetAttackPeriod(TUNING.BISHOP_ATTACK_PERIOD)
	end
end

local function RookAttach(inst, target)
	if target.components.locomotor ~= nil then
		target.components.locomotor:SetExternalSpeedMultiplier(inst, "rt_pawn_buff_rook", TUNING.RT_PAWN_BUFF_ROOK_SPEED_MULT)
	end
end

local function RookDetach(inst, target)
	if target.components.locomotor ~= nil then
		target.components.locomotor:RemoveExternalSpeedMultiplier(inst, "rt_pawn_buff_rook")
	end
end



local function OnTimerDone(inst, data)
	if data.name == "buffover" then
		inst.components.debuff:Stop()
	end
end

local function MakeBuff(name, onattachedfn, onextendedfn, ondetachedfn, duration, prefabs)
	local function OnAttached(inst, target)
		inst.entity:SetParent(target.entity)
		inst.Transform:SetPosition(0, 0, 0)
		inst:ListenForEvent("death", function()
			inst.components.debuff:Stop()
		end, target)
		
		SpawnPrefab("electricchargedfx"):SetTarget(target)
		
		if onattachedfn ~= nil then
			onattachedfn(inst, target)
		end
	end
	
	local function OnExtended(inst, target)
		inst.components.timer:StopTimer("buffover")
		inst.components.timer:StartTimer("buffover", duration)
		
		SpawnPrefab("electricchargedfx"):SetTarget(target)
		
		if onextendedfn ~= nil then
			onextendedfn(inst, target)
		end
	end
	
	local function OnDetached(inst, target)
		if ondetachedfn ~= nil then
			ondetachedfn(inst, target)
		end
		
		inst:Remove()
	end
	
	local function fn()
		local inst = CreateEntity()
		
		if not TheWorld.ismastersim then
			inst:DoTaskInTime(0, inst.Remove)
			return inst
		end
		
		inst.entity:AddTransform()
		inst.entity:Hide()
		
		inst.persists = false
		
		inst:AddTag("CLASSIFIED")
		
		inst:AddComponent("debuff")
		inst.components.debuff:SetAttachedFn(OnAttached)
		inst.components.debuff:SetDetachedFn(OnDetached)
		inst.components.debuff:SetExtendedFn(OnExtended)
		
		inst:AddComponent("timer")
		inst.components.timer:StartTimer("buffover", duration)
		inst:ListenForEvent("timerdone", OnTimerDone)
		
		return inst
	end

	return Prefab("rt_pawn_buff_"..name, fn, nil, prefabs)
end

return MakeBuff("knight", KnightAttach, nil, KnightDetach, TUNING.RT_PAWN_BUFF_DURATION),
	   MakeBuff("bishop", BishopAttach, nil, BishopDetach, TUNING.RT_PAWN_BUFF_DURATION),
	   MakeBuff("rook", RookAttach, nil, RookDetach, TUNING.RT_PAWN_BUFF_DURATION)