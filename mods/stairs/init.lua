-- stairs/init.lua

-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.


-- Global namespace for functions

stairs = {}

-- Load support for MT game translation.
local S = minetest.get_translator("stairs")
-- Same as S, but will be ignored by translation file update scripts
local T = S


-- Get setting for replace ABM

local replace = minetest.settings:get_bool("enable_stairs_replace_abm")

local function rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:get_pos()
		if placer_pos then
			param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
		end

		local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
		local fpos = finepos.y % 1

		if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
				or (fpos < -0.5 and fpos > -0.999999999) then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

local function warn_if_exists(nodename)
	if minetest.registered_nodes[nodename] then
		minetest.log("warning", "Overwriting stairs node: " .. nodename)
	end
end


-- Register stair
-- Node will be called stairs:stair_<subname>

function stairs.register_stair(subname, recipeitem, groups, images, description,
		sounds, worldaligntex)
	local src_def = minetest.registered_nodes[recipeitem]

	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
			}
			if worldaligntex then
				stair_images[i].align_style = "world"
			end
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if worldaligntex and stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	warn_if_exists("stairs:stair_" .. subname)
	minetest.register_node(":stairs:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = src_def and src_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	-- for replace ABM
	if replace then
		minetest.register_node(":stairs:stair_" .. subname .. "upside_down", {
			replace_name = "stairs:stair_" .. subname,
			groups = {slabs_replace = 1},
		})
	end

	if recipeitem then
		-- Recipe matches appearence in inventory
		minetest.register_craft({
			output = "stairs:stair_" .. subname .. " 8",
			recipe = {
				{"", "", recipeitem},
				{"", recipeitem, recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use stairs to craft full blocks again (1:1)
		minetest.register_craft({
			output = recipeitem .. " 3",
			recipe = {
				{"stairs:stair_" .. subname, "stairs:stair_" .. subname},
				{"stairs:stair_" .. subname, "stairs:stair_" .. subname},
			},
		})

	end
end


-- Register slab
-- Node will be called stairs:slab_<subname>

function stairs.register_slab(subname, recipeitem, groups, images, description,
		sounds, worldaligntex)
	local src_def = minetest.registered_nodes[recipeitem]

	-- Set world-aligned textures
	local slab_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			slab_images[i] = {
				name = image,
			}
			if worldaligntex then
				slab_images[i].align_style = "world"
			end
		else
			slab_images[i] = table.copy(image)
			if worldaligntex and image.align_style == nil then
				slab_images[i].align_style = "world"
			end
		end
	end
	local new_groups = table.copy(groups)
	new_groups.slab = 1
	warn_if_exists("stairs:slab_" .. subname)
	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = slab_images,
		use_texture_alpha = src_def and src_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			local under = minetest.get_node(pointed_thing.under)
			local wield_item = itemstack:get_name()
			local player_name = placer and placer:get_player_name() or ""

			if under and under.name:find("^stairs:slab_") then
				-- place slab using under node orientation
				local dir = minetest.dir_to_facedir(vector.subtract(
					pointed_thing.above, pointed_thing.under), true)

				local p2 = under.param2

				-- Placing a slab on an upside down slab should make it right-side up.
				if p2 >= 20 and dir == 8 then
					p2 = p2 - 20
				-- same for the opposite case: slab below normal slab
				elseif p2 <= 3 and dir == 4 then
					p2 = p2 + 20
				end

				-- else attempt to place node with proper param2
				minetest.item_place_node(ItemStack(wield_item), placer, pointed_thing, p2)
				if not minetest.is_creative_enabled(player_name) then
					itemstack:take_item()
				end
				return itemstack
			else
				return rotate_and_place(itemstack, placer, pointed_thing)
			end
		end,
	})

	-- for replace ABM
	if replace then
		minetest.register_node(":stairs:slab_" .. subname .. "upside_down", {
			replace_name = "stairs:slab_".. subname,
			groups = {slabs_replace = 1},
		})
	end

	if recipeitem then
		minetest.register_craft({
			output = "stairs:slab_" .. subname .. " 6",
			recipe = {
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use 2 slabs to craft a full block again (1:1)
		minetest.register_craft({
			output = recipeitem,
			recipe = {
				{"stairs:slab_" .. subname},
				{"stairs:slab_" .. subname},
			},
		})
	end
end


-- Optionally replace old "upside_down" nodes with new param2 versions.
-- Disabled by default.

if replace then
	minetest.register_abm({
		label = "Slab replace",
		nodenames = {"group:slabs_replace"},
		interval = 16,
		chance = 1,
		action = function(pos, node)
			node.name = minetest.registered_nodes[node.name].replace_name
			node.param2 = node.param2 + 20
			if node.param2 == 21 then
				node.param2 = 23
			elseif node.param2 == 23 then
				node.param2 = 21
			end
			minetest.set_node(pos, node)
		end,
	})
end


-- Register inner stair
-- Node will be called stairs:stair_inner_<subname>

function stairs.register_stair_inner(subname, recipeitem, groups, images,
		description, sounds, worldaligntex, full_description)
	local src_def = minetest.registered_nodes[recipeitem]

	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
			}
			if worldaligntex then
				stair_images[i].align_style = "world"
			end
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if worldaligntex and stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	if full_description then
		description = full_description
	else
		description = "Inner " .. description
	end
	warn_if_exists("stairs:stair_inner_" .. subname)
	minetest.register_node(":stairs:stair_inner_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = src_def and src_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
				{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	if recipeitem then
		minetest.register_craft({
			output = "stairs:stair_inner_" .. subname .. " 7",
			recipe = {
				{"", recipeitem, ""},
				{recipeitem, "", recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})
	end
end


-- Register outer stair
-- Node will be called stairs:stair_outer_<subname>

function stairs.register_stair_outer(subname, recipeitem, groups, images,
		description, sounds, worldaligntex, full_description)
	local src_def = minetest.registered_nodes[recipeitem]

	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
			}
			if worldaligntex then
				stair_images[i].align_style = "world"
			end
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if worldaligntex and stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	if full_description then
		description = full_description
	else
		description = "Outer " .. description
	end
	warn_if_exists("stairs:stair_outer_" .. subname)
	minetest.register_node(":stairs:stair_outer_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = src_def and src_def.use_texture_alpha,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	if recipeitem then
		minetest.register_craft({
			output = "stairs:stair_outer_" .. subname .. " 6",
			recipe = {
				{"", recipeitem, ""},
				{recipeitem, recipeitem, recipeitem},
			},
		})
	end
end


-- Stair/slab registration function.
-- Nodes will be called stairs:{stair,slab}_<subname>

function stairs.register_stair_and_slab(subname, recipeitem, groups, images,
		desc_stair, desc_slab, sounds, worldaligntex,
		desc_stair_inner, desc_stair_outer)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair,
		sounds, worldaligntex)
	stairs.register_stair_inner(subname, recipeitem, groups, images,
		desc_stair, sounds, worldaligntex, desc_stair_inner)
	stairs.register_stair_outer(subname, recipeitem, groups, images,
		desc_stair, sounds, worldaligntex, desc_stair_outer)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab,
		sounds, worldaligntex)
end

-- Local function so we can apply translations
local function my_register_stair_and_slab(subname, recipeitem, groups, images,
		desc_stair, desc_slab, sounds, worldaligntex)
	stairs.register_stair(subname, recipeitem, groups, images, S(desc_stair),
		sounds, worldaligntex)
	stairs.register_stair_inner(subname, recipeitem, groups, images, "",
		sounds, worldaligntex, T("Inner " .. desc_stair))
	stairs.register_stair_outer(subname, recipeitem, groups, images, "",
		sounds, worldaligntex, T("Outer " .. desc_stair))
	stairs.register_slab(subname, recipeitem, groups, images, S(desc_slab),
		sounds, worldaligntex)
end


-- Register default stairs and slabs

my_register_stair_and_slab(
	"stone",
	"mars:stone",
    {cracky=2, stone=1},
    {"mars_stone.png"},
	"Mars Stone Stair",
	"Mars Stone Slab",
    nil,  -- default.node_sound_wood_defaults()
    false
)

my_register_stair_and_slab(
	"cobblestone",
	"mars:cobblestone",
    {cracky=2, stone=1},
    {"mars_cobblestone.png"},
	"Mars Cobblestone Stair",
	"Mars Cobblestone Slab",
	nil,  -- default.node_sound_wood_defaults(),
	false
)

my_register_stair_and_slab(
	"brick",
	"mars:brick",
    {cracky=2, stone=1},
    {"mars_brick.png"},
	"Mars Brick Stair",
	"Mars Brick Slab",
	nil,  -- default.node_sound_wood_defaults(),
	false
)

my_register_stair_and_slab(
	"sand",
	"mars:sand",
    {crumbly=2},
    {"mars_sand.png"},
	"Mars Sand Stair",
	"Mars Sand Slab",
	nil,  -- default.node_sound_wood_defaults(),
	false
)

-- Glass stair nodes need to be registered individually to utilize specialized textures.

stairs.register_stair(
	"glass",
	"mars:glass",
	{cracky = 2, oddly_breakable_by_hand = 3},
	{"mars_glass_split_stair.png", "mars_glass.png",
	"mars_glass_stairside.png^[transformFX", "mars_glass_stairside.png",
	"mars_glass.png", "mars_glass_split_stair.png"},
	S("Glass Stair"),
	nil,  -- default.node_sound_glass_defaults(),
	false
)

stairs.register_slab(
	"glass",
	"mars:glass",
	{cracky = 2, oddly_breakable_by_hand = 3},
	{"mars_glass.png", "mars_glass.png", "mars_glass_split_stair.png"},
	S("Glass Slab"),
	nil,  -- default.node_sound_glass_defaults(),
	false
)

stairs.register_stair_inner(
	"glass",
	"default:glass",
	{cracky = 2, oddly_breakable_by_hand = 3},
	{"mars_glass_stairside.png^[transformR270", "mars_glass.png",
	"mars_glass_stairside.png^[transformFX", "mars_glass.png",
	"mars_glass.png", "mars_glass_stairside.png"},
	"",
    nil,  -- default.node_sound_glass_defaults(),
	false,
	S("Inner Glass Stair")
)

stairs.register_stair_outer(
	"glass",
	"default:glass",
	{cracky = 2, oddly_breakable_by_hand = 3},
	{"mars_glass_stairside.png^[transformR90", "mars_glass.png",
	"mars_glass_outer_stair.png", "mars_glass_stairside.png",
	"mars_glass_stairside.png^[transformR90","mars_glass_outer_stair.png"},
	"",
    nil,  -- default.node_sound_glass_defaults(),
	false,
	S("Outer Glass Stair")
)



-- Dummy calls to S() to allow translation scripts to detect the strings.
-- To update this add this code to my_register_stair_and_slab:
-- for _,x in ipairs({"","Inner ","Outer "}) do print(("S(%q)"):format(x..desc_stair)) end
-- print(("S(%q)"):format(desc_slab))

--[[
S("Wooden Stair")

--]]
