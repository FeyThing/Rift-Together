return function(self)
	self.states.hit.onenter = function(inst)
		if inst.hurtsoundoverride ~= nil then
			inst.SoundEmitter:PlaySound(inst.hurtsoundoverride)
		elseif not inst:HasTag("mime") then
			inst.SoundEmitter:PlaySound(
				inst:HasTag("girl") and
				"dontstarve/ghost/ghost_girl_howl" or
				"dontstarve/ghost/ghost_howl"
			)
		end

		inst.AnimState:PlayAnimation("hit")
		inst:ClearBufferedAction()
		inst.components.locomotor:Stop()

		if inst.components.playercontroller ~= nil then
			--Specify 3 frames of pause since "busy" tag may be
			--removed too fast for our network update interval.
			inst.components.playercontroller:RemotePausePrediction(3)
		end
	end
end