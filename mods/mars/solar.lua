
-- solar charger

minetest.register_node("mars:solar_charger", {
	description = "Mars Solar Charger",
	tiles = {
		"mars_solar_panel.png",   -- y+
		"mars_solar_charger_side.png",   -- y-
		"mars_solar_charger_side.png",  -- x+
		"mars_solar_charger_side.png",  -- x-
		"mars_solar_charger_side.png",  -- z+
		"mars_solar_charger_side.png", -- z-
		},
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
    drop = "mars:solar_charger"
})

minetest.register_node("mars:solar_charger_active", {
    description = "Mars Solar Charger",
	tiles = {
		"mars_solar_panel_active.png",   -- y+
		"mars_solar_charger_active_side.png",   -- y-
		"mars_solar_charger_active_side.png",  -- x+
		"mars_solar_charger_active_side.png",  -- x-
		"mars_solar_charger_active_side.png",  -- z+
		"mars_solar_charger_active_side.png", -- z-
		},
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {cracky=2},
    drop = "mars:solar_charger"
})

minetest.register_craft({
	output = "mars:solar_charger",
	recipe = {
		{"mars:glass", "mars:glass", "mars:glass"},
		{"mars:glass", "mars:battery_full", "mars:glass"},
		{"mars:steel_ingot", "mars:steel_ingot", "mars:steel_ingot"},
	}
})

local function swap_nodes(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

-- detect if in sunlight, and swap to active variant if so
minetest.register_abm({
	nodenames = {
		"mars:solar_charger",
		"mars:solar_charger_active"
	},
	interval = 2,
	chance = 1,
	catch_up = false,
	action = function(pos, node)
		local light = minetest.get_natural_light({x = pos.x, y = pos.y+1, z=pos.z})
		if light >= 10 and node.name == "mars:solar_charger" then
			swap_nodes(pos, "mars:solar_charger_active")
		elseif light < 10 and node.name == "mars:solar_charger_active" then
			swap_nodes(pos, "mars:solar_charger")
		end
	end,
})