local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local RADIATION_TINT = { 152 / 255, 250 / 255, 152 / 255, 1 }

local RadiationBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, nil, owner, RADIATION_TINT, "radiation_meter", nil, nil, true)

    self.topperanim = self.underNumber:AddChild(UIAnim())
    self.topperanim:GetAnimState():SetBank("status_meter")
    self.topperanim:GetAnimState():SetBuild("status_meter")
    self.topperanim:GetAnimState():PlayAnimation("anim")
    self.topperanim:GetAnimState():AnimateWhilePaused(false)
    self.topperanim:GetAnimState():SetMultColour(0, 0, 0, 0.75)
    self.topperanim:SetScale(1, -1, 1)
    self.topperanim:SetClickable(false)
    self.topperanim:GetAnimState():SetPercent("anim", 1)

    self.circleframe:GetAnimState():Hide("frame")
    self.circleframe2 = self.underNumber:AddChild(UIAnim())
    self.circleframe2:GetAnimState():SetBank("status_sanity")
    self.circleframe2:GetAnimState():SetBuild("status_sanity")
    self.circleframe2:GetAnimState():OverrideSymbol("frame_circle", "status_meter", "frame_circle")
    self.circleframe2:GetAnimState():Hide("FX")
    self.circleframe2:GetAnimState():PlayAnimation("frame")
    self.circleframe2:GetAnimState():AnimateWhilePaused(false)

    self.radiationarrow = self:AddChild(UIAnim())
    self.radiationarrow:GetAnimState():SetBank("sanity_arrow")
    self.radiationarrow:GetAnimState():SetBuild("sanity_arrow")
    self.radiationarrow:GetAnimState():PlayAnimation("neutral")
    self.radiationarrow:GetAnimState():AnimateWhilePaused(false)
    self.radiationarrow:SetClickable(false)
	
	self.icon = self.underNumber:AddChild(Image("images/rnc_hud.xml", "radiation_icon.tex"))
	local icon = 1*0.2
	self.icon:SetScale(icon, icon, icon)

    self.val = 100
    self.max = 100
    self.penaltypercent = 0

    self:StartUpdating()
end)

function RadiationBadge:SetPercent(val, max, penaltypercent)
    self.val = val
    self.max = max
    Badge.SetPercent(self, self.val, self.max)
	self.icon:SetTexture("images/rnc_hud.xml", "radiation_icon.tex")
    self.penaltypercent = penaltypercent or 0
    self.topperanim:GetAnimState():SetPercent("anim", 1 - self.penaltypercent)
end

local RATE_SCALE_ANIM =
{
    [RATE_SCALE.INCREASE_HIGH] = "arrow_loop_increase_most",
    [RATE_SCALE.INCREASE_MED] = "arrow_loop_increase_more",
    [RATE_SCALE.INCREASE_LOW] = "arrow_loop_increase",
    [RATE_SCALE.DECREASE_HIGH] = "arrow_loop_decrease_most",
    [RATE_SCALE.DECREASE_MED] = "arrow_loop_decrease_more",
    [RATE_SCALE.DECREASE_LOW] = "arrow_loop_decrease",
}

function RadiationBadge:OnUpdate(dt)
    if TheNet:IsServerPaused() then return end

    local radiation = self.owner.replica.radiation
    local anim = "neutral"

    if radiation ~= nil then
        if self.owner:HasTag("sleeping") then
            --Special case for sleeping: at night, radiation will ping between .9999 and 1 of max, so make an exception for the arrow
            if radiation:GetPercentWithPenalty() < 1 then
                anim = "arrow_loop_increase"
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
    end

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.radiationarrow:GetAnimState():PlayAnimation(anim, true)
    end
end

return RadiationBadge
