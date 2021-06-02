
minetest.register_on_joinplayer(function(player)
    if player then
        player:set_physics_override({
            gravity = 0.38, -- mars gravity is 3.711ms-1 or approx 38% of earth
        })
        
        player:set_sky({
            base_color = "#bfbaa7",
            type = "plain",
            clouds = false,
            sky_colour = {
                "#bfbaa7", -- day sky
                "#eadca3", -- day horizon
                "#928655", -- dawn sky
                "#9b9786", -- dawn horizon
            }
        })

    end
end)