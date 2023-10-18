
local function applyupgrades(inst)

	local max_upgrades = 10
	local upgrades = math.min(inst.level, max_upgrades)

--	local hunger_percent = inst.components.hunger:GetPercent()
	local health_percent = inst.components.health:GetPercent()
--	local sanity_percent = inst.components.sanity:GetPercent()

	--inst.components.hunger.max = math.ceil (150 + upgrades * 5) --200
	inst.components.health.maxhealth = math.ceil (200 + upgrades * 10) --250
	--inst.components.sanity.max = math.ceil (150 + upgrades * 5) --200
	
		
	inst.components.talker:Say("Level : ".. (inst.level))
	
	if inst.level >9 then
		inst.components.talker:Say("Level : Max!")
	end

--	inst.components.hunger:SetPercent(hunger_percent)
	inst.components.health:SetPercent(health_percent)
--	inst.components.sanity:SetPercent(sanity_percent)
	
end

	


return applyupgrades