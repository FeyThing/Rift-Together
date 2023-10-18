require "behaviours/follow"

local MIN_FOLLOW = 0
local MAX_FOLLOW = 11
local MED_FOLLOW = 6

return function(self)
	table.insert(self.bt.root.children, 1, Follow(self.inst, function() return self.inst.components.follower and self.inst.components.follower.leader end, MIN_FOLLOW, MED_FOLLOW, MAX_FOLLOW, true))
end