local function OnDeath(inst, data)
	local x, y, z = inst.Transform:GetWorldPosition()
	if data and data.afflicter and data.afflicter:HasTag("chesskiller") then
		local fx = SpawnPrefab("small_puff")
		fx.Transform:SetPosition(x, y, z)
		fx.Transform:SetScale(1.5, 1.5, 1.5)		 			
		SpawnPrefab("chessjunk"..(inst.prefab == "knight" and 5 or inst.prefab == "bishop" and 4 or 6)).Transform:SetPosition(x, y, z)
	end
end

return function(inst)
	inst:ListenForEvent("death", OnDeath)
end
