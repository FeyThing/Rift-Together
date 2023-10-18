local function ConsolePostConstruct(inst)
	local _OnBecomeActive = inst.OnBecomeActive
	function inst:OnBecomeActive()
		if not TheNet:IsDedicated() then
			if ThePlayer ~= nil then
		    		ThePlayer:PushEvent( "gamepaused", true )
			end
		end

		_OnBecomeActive(self)
	end

	local _OnBecomeInactive = inst.OnBecomeInactive
	function inst:OnBecomeInactive()
		if not TheNet:IsDedicated() then
			if ThePlayer ~= nil then
		    		ThePlayer:PushEvent( "gamepaused", false )
			end
		end

	    	_OnBecomeInactive(self)
	end

	return inst
end

AddClassPostConstruct("screens/consolescreen", ConsolePostConstruct)