AddPrefabPostInitAny(function(inst)

	if inst:HasTag("player") then	
	inst:AddComponent("radiation")
	print("Add radiation component to players.")
---------- Custom Radiation Levels
	if inst.prefab == "willow" then inst.components.radiation.max = 100 end
	if inst.prefab == "wilson" then inst.components.radiation.max = 100 end
	if inst.prefab == "wolfgang" then inst.components.radiation.max = 150 end
	if inst.prefab == "waxwell" then inst.components.radiation.max = 120 end
	if inst.prefab == "woodie" then inst.components.radiation.max = 150 end
	if inst.prefab == "wendy" then inst.components.radiation.max = 80 end
	if inst.prefab == "wickerbottom" then inst.components.radiation.max = 100 end
	if inst.prefab == "wes" then inst.components.radiation.max = 55 end
	if inst.prefab == "wathgrithr" then inst.components.radiation.max = 150 end
	if inst.prefab == "webber" then inst.components.radiation.max = 200 end		
	if inst.prefab == "wurt" then inst.components.radiation.max = 100 end
	if inst.prefab == "wortox" then inst.components.radiation.max = 150 end
	if inst.prefab == "wormwood" then inst.components.radiation.max = 200 end
	if inst.prefab == "winona" then inst.components.radiation.max = 100 end
	if inst.prefab == "wanda" then inst.components.radiation.max = 100 end
		
	
	--[[inst:ListenForEvent("startsickness", 
		function(inst, data)
			if inst.HUD then
				inst.HUD.bloodover:UpdateState() 
			end
		end,
	inst)
	
	inst:ListenForEvent("dangerouslysick", 
		function(inst, data) 
			if inst.HUD then
				inst.HUD.bloodover:UpdateState()
			end
		end,
	inst)]]
	

	-- WX78 is a robot!
	if inst.prefab == "wx78" then
		inst:AddTag("robot")
	end		
		
	end	

end)
