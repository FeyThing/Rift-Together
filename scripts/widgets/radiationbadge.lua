local Badge = require "widgets/badge"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"

local RADIATION_TINT = { 152 / 255, 250 / 255, 152 / 255, 1 }
local COMBINED_STATUS = KnownModIndex:IsModEnabled("workshop-376333686")

local RadiationBadge = Class(Badge, function(self, owner)
	Badge._ctor(self, nil, owner, RADIATION_TINT, nil, nil, true, true)
    self.owner = owner

	self.active = false

	self.anim:MoveToFront()

	self.icon = self:AddChild(Image("images/rnc_hud.xml", "radiation_icon.tex"))
	self.icon:SetScale(0.18, 0.18, 0.18)
	self.icon:Hide()

	self.topperanim = self:AddChild(UIAnim())
	self.topperanim:GetAnimState():SetBank("status_meter")
	self.topperanim:GetAnimState():SetBuild("status_meter")
	self.topperanim:GetAnimState():AnimateWhilePaused(false)
	self.topperanim:GetAnimState():SetMultColour(0, 0, 0, 0.75)
	self.topperanim:SetScale(1, -1, 1)
	self.topperanim:SetClickable(false)
	self.topperanim:GetAnimState():SetPercent("anim", 0)
	
    self.backing:GetAnimState():SetBank("status_meter")
    self.backing:GetAnimState():SetBuild("status_wet")
    self.backing:GetAnimState():Hide("frame")
    self.backing:GetAnimState():Hide("icon")
	
	self.circleframe:MoveToFront()
	self.circleframe:GetAnimState():Hide("bg")
	self.num:MoveToFront()
	if COMBINED_STATUS then self.maxnum:MoveToFront() end

    self.arrowdir = "neutral"
    self.arrow = self:AddChild(UIAnim())
    self.arrow:GetAnimState():SetBank("sanity_arrow")
    self.arrow:GetAnimState():SetBuild("sanity_arrow")
    self.arrow:GetAnimState():PlayAnimation(self.arrowdir)
    self.arrow:GetAnimState():AnimateWhilePaused(false)
    self.arrow:SetClickable(false)

	self.anim:Hide()
	self.backing:Hide()
	self.circleframe:Hide()
	if COMBINED_STATUS then
		self.bg:Hide()
		self.bg:MoveToFront()
		self.num:MoveToFront()
	end
end)

function RadiationBadge:Activate()
	self.backing:Show()
	self.circleframe:Show()

	self.backing:GetAnimState():PlayAnimation("open")
	self.circleframe:GetAnimState():PlayAnimation("open")
	self.anim:Show()
    self.num:Show()
	self.pulse:Show()
	self.icon:Show()

	if COMBINED_STATUS then
		self.num:Show()
		self.bg:Show()
	end

	self:StartUpdating()
	self:OnUpdate(0)
	TheFrontEnd:GetSound():PlaySound("dontstarve_DLC001/common/HUD_wet_open")
end

function RadiationBadge:Deactivate()
	self.backing:GetAnimState():PlayAnimation("close")
	self.circleframe:GetAnimState():PlayAnimation("close")
	self.anim:Hide()
    self.num:Hide()
	self.pulse:Hide()
	self.icon:Hide()

	if COMBINED_STATUS then
		self.num:Hide()
		self.bg:Hide()
	end

	self:StopUpdating()
	TheFrontEnd:GetSound():PlaySound("dontstarve_DLC001/common/HUD_wet_close")
end

function RadiationBadge:PulseGreen()
    self.pulse:GetAnimState():SetMultColour(0, 1, 0, 1)
    self.pulse:GetAnimState():PlayAnimation("pulse")
end

function RadiationBadge:PulseRed()
    self.pulse:GetAnimState():SetMultColour(1, 0, 0, 1)
    self.pulse:GetAnimState():PlayAnimation("pulse")
end

function RadiationBadge:SetPercent(percent, max, penaltypercent)
	if percent > 0 then
		if not self.active then
			self.active = true
			self:Activate()
		end

        self.anim:GetAnimState():SetPercent("anim", 1 - percent)
        self.num:SetString(tostring(math.ceil(percent * max)))
	elseif self.active then
		self.active = false
		self:Deactivate()
	end

	self.percent = percent
	self.max = max
	self.penaltypercent = penaltypercent or 0
	self.topperanim:GetAnimState():SetPercent("anim", 1 - self.penaltypercent)
end

local RATE_SCALE_ANIM = {
	[RATE_SCALE.INCREASE_HIGH] = "arrow_loop_increase_most",
	[RATE_SCALE.INCREASE_MED] = "arrow_loop_increase_more",
	[RATE_SCALE.INCREASE_LOW] = "arrow_loop_increase",
	[RATE_SCALE.DECREASE_HIGH] = "arrow_loop_decrease_most",
	[RATE_SCALE.DECREASE_MED] = "arrow_loop_decrease_more",
	[RATE_SCALE.DECREASE_LOW] = "arrow_loop_decrease",
}

function RadiationBadge:OnUpdate(dt)
	if TheNet:IsServerPaused() then return end

	local anim = "neutral"
	local radiation = self.owner.replica.radiation
	if self.owner:HasTag("sleeping") then
		-- Special case for sleeping: at night, radiation will ping between .9999 and 1 of max, so make an exception for the arrow
		-- LukaS: Source?
		if radiation:GetPercentWithPenalty() < 1 then
			anim = "neutral"
		end
	else
		local ratescale = radiation:GetRateScale()
		if ratescale == RATE_SCALE.INCREASE_LOW or
		ratescale == RATE_SCALE.INCREASE_MED or
		ratescale == RATE_SCALE.INCREASE_HIGH then
			if radiation:GetPercentWithPenalty() < 1 then
				anim = RATE_SCALE_ANIM[ratescale]
			end
		elseif ratescale == RATE_SCALE.DECREASE_LOW or
		ratescale == RATE_SCALE.DECREASE_MED or
		ratescale == RATE_SCALE.DECREASE_HIGH then
			if radiation:GetPercentWithPenalty() > 0 then
				anim = RATE_SCALE_ANIM[ratescale]
			end
		end
	end

	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.arrow:GetAnimState():PlayAnimation(anim, true)
	end
end

return RadiationBadge
