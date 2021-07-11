local S = awards.gettext

-- trigger types - see triggers.lua for details
-- chat     join    death
-- dig      place   craft
-- eat

-- die for the first time
awards.register_award("award_first_death",{
    title = S("Death"),
    description = S("Die for the first time."),
    icon = "death_award.png",
    hud_background = "awards_bg_default.png",
    difficulty = 1,
    trigger = {
        type = "death",
        target = 1
    }
})

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

awards.register_award("award_100_stone",{
    title = S("100 stone mined"),
    description = S("Mine 100 stone."),
    icon = "mars_stone.png",
    hud_background = "awards_bg_mining.png",
    difficulty = 2,
    trigger = {
        type = "dig",
        node = "mars:stone",
        target = 100
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

awards.register_award("award_100_sand",{
    title = S("100 sand mined"),
    description = S("Mine 100 sand."),
    icon = "mars_sand.png",
    hud_background = "awards_bg_mining.png",
    difficulty = 2,
    trigger = {
        type = "dig",
        node = "mars:sand",
        target = 100
    }
})

-- charge a battery
awards.register_award("award_charge_battery",{
    title = S("POWER!!!"),
    description = S("Charge a battery."),
    icon = "mars_battery_10.png",
    hud_background = "awards_bg_default.png",
    difficulty = 1,
    trigger = {
        type = "craft",
        node = "mars:battery_full",
        target = 1
    }
})