
minetest.register_on_joinplayer(function(player)
    if player then
        player:set_physics_override({
            gravity = 0.38, -- mars gravity is 3.711ms-1 or approx 38% of earth
        })
        player:set_sky({r=191, g=186, b=167}, "plain")
    end
end)