
function battery_power():
    energy = 10



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
	is_ground_content = true,
	groups = {cracky=2}
})

minetest.register_craftitem("mars:battery", {
    description = "Mars Battery",
    inventory_image = "mars_battery_10.png"
})