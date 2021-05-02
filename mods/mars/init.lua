
--local player = minetest.get_player_by_name(name)
--player:set_physics_override({
    --gravity = 0.38, -- mars gravity is 3.711ms-1 or approx 38% of earth
--})

--Group	                    Best Tool	       Description
--crumbly	                spade	           Dirt, sand
--cracky	                pickaxe	           Tough (but brittle) stuff like stone
--snappy	                any	               Can be cut using fine tools
--choppy	                axe	               Can be cut using a sharp force; e.g. trees, wooden planks
--fleshy	                sword	           Living things like animals and the player. This could imply some blood effects when hitting.
--explody                 	?	               Especially prone to explosions
--oddly_breakable_by_hand	any	               Torches and such - very quick to dig



minetest.register_node("mars:stone", {
	description = "Mars Stone",
	tiles = {"mars_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
    drop = "mars:cobblestone"
})

minetest.register_node("mars:stair_stone", {
    description = "Mars Stone Stair",
    tiles = {"mars_stone.png"},
    groups = {cracky=3, stone=1},
    drawtype = "nodebox",
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    }
})


minetest.register_node("mars:cobblestone", {
	description = "Mars Cobblestone",
	tiles = {"mars_cobblestone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1}
})

minetest.register_node("mars:stair_cobblestone", {
    description = "Mars Cobblestone Stair",
    tiles = {"mars_cobblestone.png"},
    drawtype = "nodebox",
    paramtype = "light",
    groups = {cracky=3, stone=1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    }
})


minetest.register_node("mars:stone_brick", {
	description = "Mars Brick",
	tiles = {"mars_brick.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1}
})

minetest.register_node("mars:stair_brick", {
    description = "Mars Brick Stair",
    tiles = {"mars_brick.png"},
    drawtype = "nodebox",
    paramtype = "light",
    groups = {cracky=3, stone=1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    }
})


minetest.register_node("mars:sand", {
	description = "Mars Sand",
	tiles = {"mars_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3}
})

minetest.register_node("mars:stair_sand", {
    description = "Mars Sand Stair",
    tiles = {"mars_sand.png"},
    drawtype = "nodebox",
    paramtype = "light",
    groups = {crumbly=3},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    }
})


minetest.register_node("mars:glass", {
	description = "Mars Glass",
    drawtype = "glasslike_framed",
	tiles = {"mars_glass.png","mars_glass_detail.png"},
    inventory_image = minetest.inventorycube("mars_glass.png"),
    paramtype = "light",
    sunlight_propagates = true, -- Sunlight can shine through block
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand = 3}
})


--minetest.register_biome({
    --name = "mars_stone",
    --node_top = "mars:stone",
    --depth_top = 1,
    --node_filler = "default:stone",
    --depth_filler = 3,
    --y_max = 1000,
    --y_min = -3,
    --heat_point = 50,
    --humidity_point = 50,
--})

minetest.register_biome({
    name = "mars_sand",
    node_top = "mars:sand",
    depth_top = 1,
    node_filler = "default:stone",
    depth_filler = 3,
    y_max = 1000,
    y_min = -3,
    heat_point = 50,
    humidity_point = 50,
})

minetest.register_alias("mapgen_stone", "mars:stone")
minetest.register_alias("mapgen_water_source", "mars:sand")
minetest.register_alias("default:cobble", "mars:stone")
itemname = minetest.registered_aliases[itemname] or itemname
