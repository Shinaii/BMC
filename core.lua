----------------
----- CORE -----

BMC = SMODS.current_mod
_G.BMC = BMC  

------------------
--- MOD LOADER ---

-- Load tag_refresh
local tag_refresh_path = BMC.config.tag_refresh.path
assert(SMODS.load_file(tag_refresh_path))()
sendInfoMessage("Tag Refresh Mod Loaded", "BMC")

-- Load reroll_shop
local reroll_shop_path = BMC.config.reroll_shop.path
assert(SMODS.load_file(reroll_shop_path))()
sendInfoMessage("Reroll Shop Mod Loaded", "BMC")


----------------------
--- MOD LOADER END ---

------------------
--- CONFIG TAB ---

local tab_content_config = {align = 'tm', r = 0.1, padding = 0.3, colour = G.C.BLACK, minh = 8, maxw = 16}
local mod_option_config = {align = 'cm', padding = 0.1, colour = G.C.BLACK, minh = 2, maxw = 16}

BMC.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 10, align = 'cm', padding = 0.1, colour = G.C.BLACK}, nodes = {
        create_tabs({
            colour = G.C.PURPLE,
            tabs = {
                {
                    label = localize('tabs_gameplay'),
                    chosen = true,
                    tab_definition_function = function() return {n = G.UIT.ROOT, config = tab_content_config, nodes={
                        {
                            n = G.UIT.R, config = {align = 'cm'}, nodes={
                                create_tabs({
                                    colour = G.C.GOLD,
                                    tabs = { 
                                        -- ALL GAMEPLAY MODS --
                                        {
                                            label = localize('gameplay_tag_refresh'),
                                            chosen = true,
                                            tab_definition_function = function() return {n = G.UIT.ROOT, config = mod_option_config, nodes={
                                                {
                                                    n = G.UIT.C, config = {align = 'tm'}, nodes={
                                                        {
                                                            n = G.UIT.R, config = {align = 'tm'}, nodes={
                                                                {n = G.UIT.T, config = {text = localize('gameplay_tag_refresh_desc'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
                                                            }
                                                        },
                                                        create_toggle({label = localize('gameplay_tag_refresh_enable'), ref_table = BMC.config.tag_refresh , ref_value = 'enable'}),
                                                        create_toggle({label = localize('gameplay_tag_refresh_newgame'), ref_table = BMC.config.tag_refresh , ref_value = 'newgame'}),
                                                    }
                                                }   
                                            }} end
                                        },
                                        {
                                            label = localize('gameplay_reroll_shop'),
                                            tab_definition_function = function() return {n = G.UIT.ROOT, config = mod_option_config, nodes={
                                                {
                                                    n = G.UIT.C, config = {align = 'tm'}, nodes={
                                                        {
                                                            n = G.UIT.R, config = {align = 'tm'}, nodes={
                                                                {n = G.UIT.T, config = {text = localize('gameplay_reroll_shop_desc'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
                                                            }
                                                        },
                                                        create_toggle({label = localize('gameplay_reroll_shop_enable'), ref_table = BMC.config.reroll_shop , ref_value = 'enable'}),
                                                        create_toggle({label = localize('gameplay_reroll_shop_booster'), ref_table = BMC.config.reroll_shop , ref_value = 'booster'}),
                                                        create_toggle({label = localize('gameplay_reroll_shop_voucher'), ref_table = BMC.config.reroll_shop , ref_value = 'voucher'}),
                                                    }
                                                }  
                                            }} end
                                        }
                                        -- ALL GAMEPLAY MODS END --
                                    }
                                })
                            }
                        }
                    }} end
                },
                {
                    label = localize('tabs_help'),
                    tab_definition_function = function() return {n = G.UIT.ROOT, config = tab_content_config, nodes={
                        {n = G.UIT.T, config = {text = localize('help'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT}},
                    }} end
                },
            }
        })
    }}
end

----------------------
--- CONFIG TAB END ---

----------------
--- CORE END ---