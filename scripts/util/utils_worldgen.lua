function AddPreferredLayout(name, fname)
    fname = fname or name
	local layouts = GLOBAL.require("map/layouts").Layouts
	local layout = GLOBAL.require("map/layouts/"..fname)
	layout.fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN
	layouts[name] = layout
end