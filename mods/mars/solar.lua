

-- solar charger

function get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;mars_hb_bg.png]"
	end
	return out
end

function get_charger_active_formspec(item_percent)
    return "size[8,8.5]"..
        "list[context;src;2.75,0.5;1,1;]"..
        "image[3.75,1.5;5,1;mars_synthesiser_arrow.png^[lowpart:"..
        (item_percent)..":mars_synthesiser_arrow.png^[transformR360]"..
        "list[context;dst;4.75,0.96;2,2;]"..
        "list[current_player;main;0,4.25;8,1;]"..
        "list[current_player;main;0,5.5;8,3;8]"..
        "listring[context;dst]"..
        "listring[current_player;main]"..
        "listring[context;src]"..
        "listring[current_player;main]"..
        "listring[current_player;main]"..
        get_hotbar_bg(0, 4.25)
end

function get_charger_inactive_formspec()
    return "size[8,8.5]"..
        "list[context;src;2.75,0.5;1,1;]"..
        "image[3.75,1.5;1,1;mars_synthesiser_arrow.png^[transformR360]"..
        "list[context;dst;4.75,0.96;2,2;]"..
        "list[current_player;main;0,4.25;8,1;]"..
        "list[current_player;main;0,5.5;8,3;8]"..
        "listring[context;dst]"..
        "listring[current_player;main]"..
        "listring[context;src]"..
        "listring[current_player;main]"..
        "listring[current_player;main]"..
        get_hotbar_bg(0, 4.25)
end

--
-- Node callback functions that are the same for active and inactive furnace
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("dst") and inv:is_empty("src")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function charger_node_timer(pos, elapsed)
	--
	-- Initialize metadata
	--
	local meta = minetest.get_meta(pos)
	local src_time = meta:get_float("src_time") or 0

	local inv = meta:get_inventory()
	local srclist
	local dst_full = false

	local timer_elapsed = meta:get_int("timer_elapsed") or 0
	meta:set_int("timer_elapsed", timer_elapsed + 1)

	local chargeable

	local update = true
	while elapsed > 0 and update do
		update = false
		srclist = inv:get_list("src")

		-- Check if we have chargeable content
		local aftercharged
		charged, aftercharged = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		chargeable = charged.time ~= 0
		src_time = meta:get_float("src_time") or 0

		el = math.min(elapsed, charged.time - src_time)

		-- If there is a chargeable item then check if it is ready yet
			if chargeable then
				src_time = src_time + el
				if src_time >= charged.time then
					-- Place result in dst list if possible
					if inv:room_for_item("dst", charged.item) then
						inv:add_item("dst", charged.item)
						inv:set_stack("src", 1, aftercharged.items[1])
						src_time = src_time - charged.time
						update = true
					else
						dst_full = true
					end
				else
					-- Item could not be cooked:
					update = true
				end
			else
				if not chargeable then
					src_time = 0
				end
			end	
		elapsed = elapsed - el
	end

	if srclist and srclist[1]:is_empty() then
		src_time = 0
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec
	local item_state
	local item_percent = 0
	if chargeable then
		item_percent = math.floor(src_time / charged.time * 100)
		if dst_full then
			item_state = "100% (output full)"
		else
			item_state = item_percent .. "%"
		end
	else
		if srclist and not srclist[1]:is_empty() then
			item_state = "Not chargeable"
		else
			item_state = "Empty"
		end
	end

	local active = "inactive"
	local result = false

	if not chargeable then
		active = "inactive"
		formspec = get_furnace_inactive_formspec()
		-- stop timer on the inactive charger
		minetest.get_node_timer(pos):stop()
		meta:set_int("timer_elapsed", 0)
	else
		active = "active"
		formspec = get_charger_active_formspec(item_percent)
		-- make sure timer restarts automatically
		result = true
	end

	local infotext = "Charger " .. active .. "\n(Item: " .. item_state .. ")"

	--
	-- Set meta values
	--
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end



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
    legacy_facedir_simple = true,
	is_ground_content = false,

	can_dig = can_dig,

	on_timer = charger_node_timer,

    on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('dst', 4)
		charger_node_timer(pos, 0)
	end,

	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether the item can be charged or not
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_take = function(pos)
		-- check whether the charger is empty or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_blast = function(pos)
		local drops = {}
		get_inventory_drops(pos, "src", drops)
		get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "mars:solar_charger"
		minetest.remove_node(pos)
		return drops
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})


minetest.register_node("mars:synthesiser_active", {
    description = "Mars synthesiser",
	tiles = {
		"mars_solar_panel_active.png",   -- y+
		"mars_solar_charger_active_side.png",   -- y-
		"mars_solar_charger_active_side.png",  -- x+
		"mars_solar_charger_active_side.png",  -- x-
		"mars_solar_charger_active_side.png",  -- z+
		"mars_solar_charger_active_side.png", -- z-
		},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "mars:synthesiser",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	on_timer = furnace_node_timer,

	can_dig = can_dig,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})