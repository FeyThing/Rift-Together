local function TextEditConstruct(inst)
	local _SetEditing = inst.SetEditing
	function inst:SetEditing(editing)
		if not TheNet:IsDedicated() then
			if ThePlayer then
		    		ThePlayer:PushEvent( "gamepaused", editing )
			end
		end	
		_SetEditing(self, editing)
	
	end

	local _OnDestroy = inst.OnDestroy
	function inst:OnDestroy()
		if not TheNet:IsDedicated() then
			if ThePlayer then
		    		ThePlayer:PushEvent( "gamepaused", editing )
			end
		end
		_OnDestroy(self)
	end

	return inst
end


AddClassPostConstruct("widgets/textedit", TextEditConstruct)