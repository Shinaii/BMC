--- Reroll Packs Mod ---
---
local _reroll_shop = G.FUNCS.reroll_shop

function G.FUNCS.reroll_shop(e)
    _reroll_shop(e) -- Call the original function so that upper cards get rerolled

    
    if BMC.config.reroll_shop.enable then
        if BMC.config.reroll_shop.booster then
        -- Booster reroll
            reroll_shop_booster()
        end

        if BMC.config.reroll_shop.voucher then
        -- Voucher reroll
            reroll_shop_voucher()
        end
    end
end


function reroll_shop_booster()

    -- Remove all cards from the shop booster
    
    for i = #G.shop_booster.cards, 1, -1 do
        G.shop_booster.cards[i]:remove()
        G.shop_booster.cards[i] = nil
    end

-- Add new cards to the shop booster
    local shop_booster = G.shop_booster
    local booster_pos = shop_booster.T
    local card_width = G.CARD_W * 1.27
    local card_height = G.CARD_H * 1.27

    for i = 1, 2 do
        G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
        local card = Card(
            booster_pos.x + booster_pos.w / 2,
            booster_pos.y,
            card_width,
            card_height,
            G.P_CARDS.empty,
            G.P_CENTERS[G.GAME.current_round.used_packs[i]],
            { bypass_discovery_center = true, bypass_discovery_ui = true }
        )
        create_shop_card_ui(card, 'Booster', shop_booster)
        card.ability.booster_pos = i
        card:start_materialize()
        shop_booster:emplace(card)
    end
end

function reroll_shop_voucher()

    -- Remove all cards from the shop voucher
    for i = #G.shop_vouchers.cards, 1, -1 do
        G.shop_vouchers.cards[i]:remove()
        G.shop_vouchers.cards[i] = nil
    end

    local function get_new_voucher(current_voucher)
        local new_voucher
        repeat
            new_voucher = get_next_voucher_key()  
        until new_voucher ~= current_voucher
        return new_voucher
    end

    -- get new voucher
    G.GAME.current_round.voucher = get_new_voucher(G.GAME.current_round.voucher)

    -- Add new cards to the shop voucher
    
    if G.GAME.current_round.voucher and G.P_CENTERS[G.GAME.current_round.voucher] then
        local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
        G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.voucher],{bypass_discovery_center = true, bypass_discovery_ui = true})
        card.shop_voucher = true
        create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
        card:start_materialize()
        G.shop_vouchers:emplace(card)
    end
end