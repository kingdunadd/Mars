
minetest.register_on_joinplayer(function(player)
    if player then
        --local player = minetest.get_player_by_name("singleplayer") or minetest.get_player_by_name(name)
        player:set_physics_override({
            gravity = 0.38, -- mars gravity is 3.711ms-1 or approx 38% of earth
        })
    end
end)