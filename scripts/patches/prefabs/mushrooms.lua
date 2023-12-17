return function(inst)

--local function fn()
--CLIENT
	if not TheWorld.ismastersim then
		return
	end
	--SERVER
        inst.components.edible.radiationvalue = -2				
		   --return inst
    --end
end