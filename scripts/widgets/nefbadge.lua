local Badge = require "widgets/badge" -- badge template to be used 
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"

local nefenergy  = Class(Badge, function(self, owner)
    Badge._ctor(self, nil, owner, {65/255, 105/255, 225/255, 1}) -- "nil" here is supposed to be the badge's art, but we couldn't figure it out. It'll use the default badge art without a icon.--  { 174 / 255, 21 / 255, 21 / 255, 1 } = colour in an rbg format

	self.backing = self.underNumber:AddChild(UIAnim())
    self.backing:GetAnimState():SetBank("status_meter")
    self.backing:GetAnimState():SetBuild("status_meter")
    self.backing:GetAnimState():PlayAnimation("bg")
	self.backing:GetAnimState():SetMultColour(0.2, 0.2, 0.2, 1)

	self.anim = self.underNumber:AddChild(UIAnim())
	self.anim:GetAnimState():SetBank("status_meter")
	self.anim:GetAnimState():SetBuild("status_meter")
	self.anim:GetAnimState():PlayAnimation("anim")

	self.circleframe = self.underNumber:AddChild(UIAnim())
    self.circleframe:GetAnimState():SetBank("status_meter")
    self.circleframe:GetAnimState():SetBuild("status_meter")
    self.circleframe:GetAnimState():PlayAnimation("frame")

	self.icon = self.underNumber:AddChild(Image("images/rnc_hud.xml", "bolt-1.tex"))
	local icon = 1*0.2
	self.icon:SetScale(icon, icon, icon)


	self.num = self:AddChild(Text(BODYTEXTFONT, 33))
    self.num:SetHAlign(ANCHOR_MIDDLE)
    self.num:SetPosition(3, 0, 0)
    self.num:Hide()
    self:StartUpdating()
end)
function nefenergy:SetPercent(val, max,owner)
	max = max or TUNING.NEFARIOUS_ENERGY
	val = val or 0

	if val >= 0.75 then
		self.icon:SetTexture("images/rnc_hud.xml", "bolt-4.tex")	
	elseif val>=0.5 then
		self.icon:SetTexture("images/rnc_hud.xml", "bolt-3.tex")	
	elseif val>=0.25 then
		self.icon:SetTexture("images/rnc_hud.xml", "bolt-2.tex")	
	else
		self.icon:SetTexture("images/rnc_hud.xml", "bolt-1.tex")	
	end
	
	self.anim:GetAnimState():SetPercent("anim", 1 - val)
	self.anim:GetAnimState():SetMultColour(0/255, 255/255, 219/255, 1)
	self.circleframe:GetAnimState():SetMultColour(0/255, 115/255, 255/255, 1)
	self.num:SetString(tostring(math.ceil(val * max)))
	
	if KnownModIndex:IsModEnabled("workshop-376333686") then
		self.num:Show()
		self.num:SetPosition(1, -40, 0)
		self.num:SetScale(.75, .75, .75)
		if self.show_progress then
			if self.show_remaining then
				self.maxnum:SetString(tostring(math.floor(val * max)))
			end
		else
			self.maxnum:SetString(tostring(max))
		end
	else
		self.num:SetPosition(3, 0, 0)
	end
end
function nefenergy:OnUpdate(dt)

end

return nefenergy