
--local player = minetest.get_player_by_name(name)
--player:set_physics_override({
    --gravity = 0.38, -- mars gravity is 3.711ms-1 or approx 38% of earth
--})


-- pickaxes
minetest.register_tool("mars:pickaxe_stone", {
    description = "Mars Stone Pickaxe",
    inventory_image = "mars_stone_pickaxe.png",
    tool_capabilities = {
        tool_capabilities = {
            full_punch_interval = 1.3,
            max_drop_level=0,
            groupcaps={
                cracky = {times={[2]=2.0, [3]=1.00}, uses=20, maxlevel=1},
            },
            damage_groups = {fleshy=3},
        },
        groups = {pickaxe = 1}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "mars:pickaxe_stone",
    recipe = {
        {"mars:stone", "mars:stone",      "mars:stone"},
        {"",           "mars:steel_rod",  ""},
        {"",           "mars:steel_rod",  ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "mars:pickaxe_stone",
    recipe = {
        {"mars:cobblestone", "mars:cobblestone",     "mars:cobblestone"},
        {"",                 "mars:steel_rod",       ""},
        {"",                 "mars:steel_rod",       ""}
    }
})


minetest.register_tool("mars:pickaxe_steel", {
    description = "Mars Steel Pickaxe",
    inventory_image = "mars_steel_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	groups = {pickaxe = 1}
})

minetest.register_craft({
    type = "shaped",
    output = "mars:pickaxe_steel",
    recipe = {
        {"mars:steel_ingot", "mars:steel_ingot",   "mars:steel_ingot"},
        {"",                "mars:steel_rod",    ""},
        {"",                "mars:steel_rod",    ""}
    }
})

-- shovels
minetest.register_tool("mars:shovel_stone", {
	description = "Mars Stone Shovel",
	inventory_image = "mars_stone_shovel.png",
	wield_image = "mars_stone_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.4,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	groups = {shovel = 1}
})

minetest.register_craft({
    type = "shaped",
    output = "mars:shovel_stone",
    recipe = {
        {"", "mars:stone",      ""},
        {"", "mars:steel_rod",  ""},
        {"", "mars:steel_rod",  ""}
    }
})

minetest.register_craft({
    type = "shaped",
    output = "mars:shovel_stone",
    recipe = {
        {"", "mars:cobblestone",      ""},
        {"", "mars:steel_rod",  ""},
        {"", "mars:steel_rod",  ""}
    }
})

minetest.register_tool("mars:shovel_steel", {
	description = "Mars Steel Shovel",
	inventory_image = "mars_steel_shovel.png",
	wield_image = "mars_steel_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
	groups = {shovel = 1}
})

minetest.register_craft({
    type = "shaped",
    output = "mars:shovel_steel",
    recipe = {
        {"", "mars:steel_ingot",      ""},
        {"", "mars:steel_rod",  ""},
        {"", "mars:steel_rod",  ""}
    }
})


--Group	                    Best Tool	       Description
--crumbly	                spade	           Dirt, sand
--cracky	                pickaxe	           Tough (but brittle) stuff like stone
--snappy	                any	               Can be cut using fine tools
--choppy	                axe	               Can be cut using a sharp force; e.g. trees, wooden planks
--fleshy	                sword	           Living things like animals and the player. This could imply some blood effects when hitting.
--explody                 	?	               Especially prone to explosions
--oddly_breakable_by_hand	any	               Torches and such - very quick to dig

minetest.register_node("mars:stone_with_iron", {
	description = "Mars Stone with Iron Ore",
	tiles = {"mars_stone_with_iron.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
    drop = "mars:iron_ore"
})

minetest.register_craftitem("mars:iron_ore", {
    description = "Mars Iron Ore",
    inventory_image = "mars_iron_ore.png"
})

minetest.register_craftitem("mars:steel_ingot", {
    description = "Mars Steel Ingot",
    inventory_image = "mars_steel_ingot.png"
})

minetest.register_craft({
    type = "cooking",
    output = "mars:steel_ingot",
    recipe = "mars:iron_ore",
    cooktime = 10,
})

minetest.register_craftitem("mars:steel_rod", {
    description = "Mars Steel Rod",
    inventory_image = "mars_steel_rod.png"
})

minetest.register_craft({
    type = "shaped",
    output = "mars:steel_rod 4",
    recipe = {
        {"mars:steel_ingot"},
        {"mars:steel_ingot"}
    }
})


-- stone
minetest.register_node("mars:stone", {
	description = "Mars Stone",
	tiles = {"mars_stone.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1},
    drop = "mars:cobblestone"
})

minetest.register_node("mars:stair_stone", {
    description = "Mars Stone Stair",
    tiles = {"mars_stone.png"},
    groups = {cracky=2, stone=1},
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

minetest.register_craft({
    type = "shaped",
    output = "mars:stair_stone 6",
    recipe = {
        {"",           "",           "mars:stone"},
        {"",           "mars:stone", "mars:stone"},
        {"mars:stone", "mars:stone", "mars:stone"}
    }
})

-- cobblestone

minetest.register_node("mars:cobblestone", {
	description = "Mars Cobblestone",
	tiles = {"mars_cobblestone.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1}
})

minetest.register_node("mars:stair_cobblestone", {
    description = "Mars Cobblestone Stair",
    tiles = {"mars_cobblestone.png"},
    drawtype = "nodebox",
    paramtype = "light",
    groups = {cracky=2, stone=1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    }
})

minetest.register_craft({
    type = "shaped",
    output = "mars:stair_cobblestone 6",
    recipe = {
        {"",                 "",                 "mars:cobblestone"},
        {"",                 "mars:cobblestone", "mars:cobblestone"},
        {"mars:cobblestone", "mars:cobblestone", "mars:cobblestone"}
    }
})


-- stone brick
minetest.register_node("mars:stone_brick", {
	description = "Mars Brick",
	tiles = {"mars_brick.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1}
})

minetest.register_node("mars:stair_brick", {
    description = "Mars Brick Stair",
    tiles = {"mars_brick.png"},
    drawtype = "nodebox",
    paramtype = "light",
    groups = {cracky=2, stone=1},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    }
})

minetest.register_craft({
    type = "shaped",
    output = "mars:stair_brick 6",
    recipe = {
        {"",                 "",                 "mars:stone_brick"},
        {"",                 "mars:stone_brick", "mars:stone_brick"},
        {"mars:stone_brick", "mars:stone_brick", "mars:stone_brick"}
    }
})


-- sand
minetest.register_node("mars:sand", {
	description = "Mars Sand",
	tiles = {"mars_sand.png"},
	is_ground_content = true,
	groups = {crumbly=2}
})

minetest.register_node("mars:stair_sand", {
    description = "Mars Sand Stair",
    tiles = {"mars_sand.png"},
    drawtype = "nodebox",
    paramtype = "light",
    groups = {crumbly=2},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    }
})

minetest.register_craft({
    type = "shaped",
    output = "mars:stair_sand 6",
    recipe = {
        {"",          "",          "mars:sand"},
        {"",          "mars:sand", "mars:sand"},
        {"mars:sand", "mars:sand", "mars:sand"}
    }
})


-- glass
minetest.register_node("mars:glass", {
	description = "Mars Glass",
    drawtype = "glasslike_framed",
	tiles = {"mars_glass.png","mars_glass_detail.png"},
    inventory_image = minetest.inventorycube("mars_glass.png"),
    paramtype = "light",
    sunlight_propagates = true, -- Sunlight can shine through block
	is_ground_content = true,
	groups = {cracky=2, oddly_breakable_by_hand = 3}
})

minetest.register_craft({
    type = "cooking",
    output = "mars:sand",
    recipe = "mars:glass",
    cooktime = 5,
})

minetest.register_node("mars:air", {
    description = "Mars Air (how are you seeing this?!)",
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable     = false, -- Would make the player collide with the air node
    pointable    = false, -- You can't select the node
    diggable     = false, -- You can't dig the node
    buildable_to = true,  -- Nodes can be replace this node.
                          -- (you can place a node and remove the air node
                          -- that used to be there)
    air_equivalent = true,
    drop = "",
    groups = {not_in_creative_inventory=1}
})



minetest.register_alias("stone", "mars:stone")
minetest.register_alias("glass", "mars:glass")


-- biomes

minetest.set_mapgen_setting("mg_flags", "caves, nodungeons, light, decorations, biomes", true)

minetest.clear_registered_biomes()
minetest.clear_registered_decorations()

minetest.register_alias("mapgen_stone", "mars:stone")
minetest.register_alias("mapgen_water_source", "mars:sand")
minetest.register_alias("mapgen_river_water_source", "mars:sand")

minetest.register_alias("mapgen_apple","mars:stone")
minetest.register_alias("mapgen_dirt","mars:stone")
minetest.register_alias("mapgen_dirt_with_grass","mars:stone")
minetest.register_alias("mapgen_cobble","mars:stone")
minetest.register_alias("mapgen_gravel","mars:stone_with_iron")
minetest.register_alias("mapgen_junglegrass","mars:stone")
minetest.register_alias("mapgen_lava_source","mars:air")
minetest.register_alias("mapgen_leaves","mars:stone")
minetest.register_alias("mapgen_mossycobble","mars:stone")
minetest.register_alias("mapgen_sand","mars:sand")
minetest.register_alias("mapgen_stair_cobble","mars:stair_stone")
minetest.register_alias("mapgen_tree","mars:stone")




minetest.register_biome({
    name = "mars_surface",
    node_top = "mars:stone",
    depth_top = 1,
    -- Node forming surface layer of biome and thickness of this layer
    node_filler = "mars:stone",
    depth_filler = 3,
    -- Node forming lower layer of biome and thickness of this layer
    node_stone = "mars:stone",
    -- Node that replaces all stone nodes between roughly y_min and y_max.
    node_water = "mars:sand",
    -- Node that replaces all seawater nodes not in the surface layer
    node_river_water = "mars:sand",
    -- Node that replaces river water in mapgens that use
    -- default:river_water
    node_riverbed = "mars:sand",
    depth_riverbed = 2,
    -- Node placed under river water and thickness of this layer
    node_cave_liquid = "mars:air",
    node_cave_liquid = {"mars:air", "mars:air"},
    -- Nodes placed inside 50% of the medium size caves.
    -- Multiple nodes can be specified, each cave will use a randomly
    -- chosen node from the list.
    -- If this field is left out or 'nil', cave liquids fall back to
    -- classic behaviour of lava and water distributed using 3D noise.
    -- For no cave liquid, specify "air".
    y_max = 1000,
    y_min = 1,
    vertical_blend = 8,
    -- Vertical distance in nodes above 'y_max' over which the biome will
    -- blend with the biome above.
    -- Set to 0 for no vertical blend. Defaults to 0.
    heat_point = 50,
    humidity_point = 50,
    -- Characteristic temperature and humidity for the biome.
    -- These values create 'biome points' on a voronoi diagram with heat and
    -- humidity as axes. The resulting voronoi cells determine the
    -- distribution of the biomes.
    -- Heat and humidity have average values of 50, vary mostly between
    -- 0 and 100 but can exceed these values.
})

minetest.register_ore({
    ore_type = "puff",
    ore = "mars:stone_with_iron",
    ore_param2 = 3,
    -- Facedir rotation. Default is 0 (unchanged rotation)
    wherein = "mars:stone",
    -- A list of nodenames is supported too
    clust_scarcity = 1,
    -- Ore has a 1 out of clust_scarcity chance of spawning in a node.
    -- If the desired average distance between ores is 'd', set this to
    -- d * d * d.
    clust_num_ores = 12,
    -- Number of ores in a cluster
    clust_size = 10,
    -- Size of the bounding box of the cluster.
    -- In this example, there is a 3 * 3 * 3 cluster where 8 out of the 27
    -- nodes are coal ore.
    y_min = -31000,
    y_max = 64,
    -- Lower and upper limits for ore
    flags = "",
    -- Attributes for the ore generation, see 'Ore attributes' section above
    noise_threshold = 0.5,
    -- If noise is above this threshold, ore is placed. Not needed for a
    -- uniform distribution.
    noise_params = {
        offset = 0,
        scale = 1,
        spread = {x = 100, y = 100, z = 100},
        seed = 23,
        octaves = 3,
        persist = 0.7
    },
    -- NoiseParams structure describing one of the perlin noises used for
    -- ore distribution.
    -- Needed by "sheet", "puff", "blob" and "vein" ores.
    -- Omit from "scatter" ore for a uniform ore distribution.
    -- Omit from "stratum" ore for a simple horizontal strata from y_min to
    -- y_max.
    biomes = {"mars_surface"},
    -- List of biomes in which this ore occurs.
    -- Occurs in all biomes if this is omitted, and ignored if the Mapgen
    -- being used does not support biomes.
    -- Can be a list of (or a single) biome names, IDs, or definitions.
    -- Type-specific parameters
    -- sheet
    column_height_min = 1,
    column_height_max = 16,
    column_midpoint_factor = 0.5,

    -- puff
    np_puff_top = {
        offset = 4,
        scale = 2,
        spread = {x = 100, y = 100, z = 100},
        seed = 47,
        octaves = 3,
        persist = 0.7
    },
    np_puff_bottom = {
        offset = 4,
        scale = 2,
        spread = {x = 100, y = 100, z = 100},
        seed = 11,
        octaves = 3,
        persist = 0.7
    },

})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"mars:sand"},
    sidelen = 16,
    fill_ratio = 0.01,
    biomes = {"mars_surface"},
    y_max = 100,
    y_min = -500,
    decoration = "rocks:sand_flat",
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"mars:stone"},
    sidelen = 16,
    fill_ratio = 0.04,
    biomes = {"mars_surface"},
    y_max = 500,
    y_min = 1,
    decoration = "rocks:stone_round",
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"mars:stone"},
    sidelen = 16,
    fill_ratio = 0.03,
    biomes = {"mars_surface"},
    y_max = 500,
    y_min = 1,
    decoration = "rocks:stone_stub",
})


-- -- load furnace file
local path = minetest.get_modpath("mars")

dofile(path.."/furnace.lua")