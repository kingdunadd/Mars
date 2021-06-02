

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

-- iron
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

minetest.register_node("mars:steel_block", {
	description = "Mars Steel Block",
	tiles = {"mars_steel_block.png"},
	is_ground_content = true,
	groups = {cracky=2}
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
    output = "mars:steel_rod 8",
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


-- cobblestone

minetest.register_node("mars:cobblestone", {
	description = "Mars Cobblestone",
	tiles = {"mars_cobblestone.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1}
})

minetest.register_craft({
    type = "cooking",
    output = "mars:stone",
    recipe = "mars:cobblestone",
    cooktime = 5,
})


-- stone brick
minetest.register_node("mars:stone_brick", {
	description = "Mars Brick",
	tiles = {"mars_brick.png"},
	is_ground_content = true,
	groups = {cracky=2, stone=1}
})

minetest.register_craft({
    type = "shaped",
    output = "mars:stone_brick 9",
    recipe = {
        {"mars:cobblestone","mars:cobblestone","mars:cobblestone"},
        {"mars:sand",       "mars:sand",        "mars:sand"},
        {"mars:cobblestone","mars:cobblestone","mars:cobblestone"}
    }
})

-- sand
minetest.register_node("mars:sand", {
	description = "Mars Sand",
	tiles = {"mars_sand.png"},
	is_ground_content = true,
	groups = {crumbly=2}
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
	groups = {cracky=2, oddly_breakable_by_hand = 1}
})


minetest.register_craft({
    type = "cooking",
    output = "mars:glass",
    recipe = "mars:sand",
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





-- -- load other files
local path = minetest.get_modpath("mars")

dofile(path.."/synthesiser.lua")
dofile(path.."/biomes.lua")
dofile(path.."/player.lua")
dofile(path.."/aliases.lua")
dofile(path.."/solar.lua")

