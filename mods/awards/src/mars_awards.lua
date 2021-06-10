local S = awards.gettext


-- mine 1 stone
awards.register_award("award_start_mine_stone",{
    title = S("First stone mined"),
    description = S("Mine 1 stone."),
    icon = "mars_stone.png",
    hud_background = "awards_bg_mining.png",
    difficulty = 1,
    trigger = {
        type = "dig",
        node = "mars:stone",
        target = 1
    }
})

-- mine 1 sand
awards.register_award("award_start_mine_sand",{
    title = S("First sand mined"),
    description = S("Mine 1 sand."),
    icon = "mars_sand.png",
    hud_background = "awards_bg_mining.png",
    difficulty = 1,
    trigger = {
        type = "dig",
        node = "mars:sand",
        target = 1
    }
})