
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
    node_riverbed = "mars:stand",
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

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"mars:sand"},
    sidelen = 16,
    fill_ratio = 0.1,
    biomes = {"mars_sand"},
    y_max = 500,
    y_min = 1,
    decoration = "rocks:sand_flat",
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"mars:sand"},
    sidelen = 16,
    fill_ratio = 0.1,
    biomes = {"mars_sand"},
    y_max = 500,
    y_min = 1,
    decoration = "rocks:sand_round",
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"mars:sand"},
    sidelen = 16,
    fill_ratio = 0.1,
    biomes = {"mars_sand"},
    y_max = 500,
    y_min = 1,
    decoration = "rocks:sand_stub",
})

minetest.register_alias("mapgen_stone", "mars:stone")
minetest.register_alias("mapgen_water_source", "mars:sand")
minetest.register_alias("mapgen_river_water_source", "mars:sand")

minetest.register_alias("stone", "mars:stone")
minetest.register_alias("glass", "mars:glass")
