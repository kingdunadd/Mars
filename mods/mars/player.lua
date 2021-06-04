
local start_items = {["mars:pickaxe_steel"] = 1, ["mars:synthesiser"] = 1, ["mars:solar_charger"] = 1, ["mars:battery10"] = 10}


minetest.register_on_newplayer(function(player)
    if player then
        minetest.chat_send_all("Hello and welcome to Mars!")
        minetest.chat_send_all("You have been send on a one-way mission to Mars.")
        minetest.chat_send_all("Survive and if you can find the resorces, you can terraform the planet.")
        local name = player:get_player_name()
        local inv = player:get_inventory()
        for everyname, count in pairs(start_items) do
            inv:add_item("main", {count = count, name = everyname})
        end
    end
end)

-- if player then
        

--     -- while minetest.get_timeofday() <= 6000 and minetest.get_timeofday() >= 21000 do
--     --     player:set_sky({
--     --         base_color = "#000000",
--     --         type = "plain",
--     --         clouds = false
--     --     })
--     -- end
-- end

minetest.register_on_joinplayer(function(player)
    if player then
        player:set_physics_override({
            gravity = 0.38, -- mars gravity is 3.711ms-1 or approx 38% of earth
        })
        player:set_sky({
            base_color = "#e1d4a4",
            type = "regular",
            clouds = false,
            sky_color = {"#e1d4a4"}
        })
    end
end)