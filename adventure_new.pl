/*
╔════════════════════════════════╗
║ Filename: adventure_new.pl     ║
║ Title: Fresh game start state. ║
╚════════════════════════════════╝
*/

% Default starting game state / scenario.

adv_i_am_at(tile_0_3).

adv_in_inventory(player, coin, 50000).
adv_in_inventory(player, mercenary, 4).

adv_price(rum, 35).  % a bottle
adv_price(gunpowder, 10).  % for one shot
adv_price(blunderbuss, 250).
adv_price(ration, 10).
adv_price(map_piece_2, 1500).
adv_price(banana, 12).
adv_price(mercenary, 500).

adv_worth(rum, 50).
adv_worth(gunpowder, 30).
adv_worth(blunderbuss, 30).
adv_worth(ration, 10).
adv_worth(banana, 10).
adv_worth(map_piece_1, 5000).
adv_worth(map_piece_2, 5000).
adv_worth(map_piece_3, 5000).
adv_worth(mercenary, -1000).
adv_worth(coin, 1).

pirates_min_th(5000).
pirates_max_th(25000).
pirates_max_pc(0.3).