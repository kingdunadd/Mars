
minetest.register_on_joinplayer(function(player)
    if player then
        player:set_physics_override({
            gravity = 0.38, -- mars gravity is 3.711ms-1 or approx 38% of earth
        })
        local time = minetest.get_timeofday()
        if time >= 5000 and time <= 20000 then
            player:set_sky({r=0, g=0, b=0}, "plain")
        else
            player:set_sky({r=191, g=186, b=167}, "plain")
        end
    end
end)