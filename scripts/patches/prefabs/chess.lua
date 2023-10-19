local function OnDeath(inst, data)
	local x, y, z = inst.Transform:GetWorldPosition()
	if data and data.afflicter and data.afflicter:HasTag("chesskiller") then
		local fx = SpawnPrefab("small_puff")
		fx.Transform:SetPosition(x, y, z)
		fx.Transform:SetScale(1.5, 1.5, 1.5)		 			
		local junk = SpawnPrefab("chessjunk"..(inst.prefab == "knight" and 2 or inst.prefab == "bishop" and 1 or 3))
		junk.Transform:SetPosition(x, y, z)
		junk:SetLessLoot()
	end
end

return function(inst)
	inst:ListenForEvent("death", OnDeath)
end
