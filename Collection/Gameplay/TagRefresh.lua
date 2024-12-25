--- TAG REFRESH MOD ---

function G.FUNCS.reroll_tags()
    G.GAME.round_resets.blind_tags.Small = get_next_tag_key()
    G.GAME.round_resets.blind_tags.Big = get_next_tag_key()

    -- Remove old blind select boxes
    local function remove_old_blind_select_boxes()
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.blind_select.alignment.offset.y = 40
                G.blind_select.alignment.offset.x = 0
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.blind_select:remove()
                G.blind_prompt_box:remove()
                G.blind_select = nil
                delay(0.2)
                return true
            end
        }))
    end

    -- Create new blind select boxes
    local function create_new_blind_select_boxes()
        G.E_MANAGER:add_event(Event({
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        play_sound('cancel')
                        G.blind_select = UIBox {
                            definition = create_UIBox_blind_select(),
                            config = { align = "bmi", offset = { x = 0, y = G.ROOM.T.y + 29 }, major = G.hand, bond = 'Weak' }
                        }
                        G.blind_select.alignment.offset.y = 0.8 - (G.hand.T.y - G.jokers.T.y) + G.blind_select.T.h
                        G.ROOM.jiggle = G.ROOM.jiggle + 3
                        G.blind_select.alignment.offset.x = 0
                        G.CONTROLLER.lock_input = false

                        for _, tag in ipairs(G.GAME.tags) do
                            tag:apply_to_run({ type = 'immediate' })
                        end

                        for _, tag in ipairs(G.GAME.tags) do
                            if tag:apply_to_run({ type = 'new_blind_choice' }) then break end
                        end

                        return true
                    end
                }))
                return true
            end
        }))
    end

    -- Execute functions to remove old and create new blind select boxes
    remove_old_blind_select_boxes()
    create_new_blind_select_boxes()
end

-- Override love.keypressed
local keyboardKey = BMC.config.tag_refresh.refresh_key
local gamepadKey = BMC.config.tag_refresh.refresh_gamepad
local ref = love.keypressed
function love.keypressed(key)
    ref(key)
    if BMC.config.tag_refresh.enable then
        if key == keyboardKey and G.STATE == G.STATES.BLIND_SELECT and G.GAME.round_resets.blind_tags and G.blind_select then
            if BMC.config.tag_refresh.newgame then
                if G.GAME.round == 0 then
                    G.FUNCS.reroll_tags()
                end
            else
                G.FUNCS.reroll_tags()
            end
        end
    end
end

-- Override love.gamepadpressed
local refgpad = love.gamepadpressed
function love.gamepadpressed(joystick, button)
    refgpad(joystick, button)
    if button == gamepadKey and G.STATE == G.STATES.BLIND_SELECT and G.GAME.round_resets.blind_tags and G.blind_select then
        if BMC.config.tag_refresh.newgame then
            if G.GAME.round == 0 then
                G.FUNCS.reroll_tags()
            end
        else
            G.FUNCS.reroll_tags()
        end
    end
end