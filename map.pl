:-assert(map_buying(tile_0_3, banana, 1.3)).
:-assert(map_buying(tile_0_3, blunderbuss, 1.1)).
:-assert(map_buying(tile_0_3, gunpowder, 1.5)).
:-assert(map_buying(tile_0_3, ration, 0.7)).
:-assert(map_buying(tile_0_3, rum, 1.1)).
:-assert(map_buying(tile_2_2, banana, 1.1)).
:-assert(map_buying(tile_2_2, blunderbuss, 0.5)).
:-assert(map_buying(tile_2_2, gunpowder, 0.5)).
:-assert(map_buying(tile_2_2, ration, 1.7)).
:-assert(map_buying(tile_2_2, rum, 1.3)).
:-assert(map_buying(tile_3_0, banana, 0.9)).
:-assert(map_buying(tile_3_0, blunderbuss, 0.9)).
:-assert(map_buying(tile_3_0, gunpowder, 0.9)).
:-assert(map_buying(tile_3_0, ration, 0.9)).
:-assert(map_buying(tile_3_0, rum, 0.9)).
:-assert(map_buying(tile_4_5, banana, 1.6)).
:-assert(map_buying(tile_4_5, blunderbuss, 1.1)).
:-assert(map_buying(tile_4_5, gunpowder, 1.3)).
:-assert(map_buying(tile_4_5, ration, 0.9)).
:-assert(map_buying(tile_4_5, rum, 1.1)).
:-assert(map_island_name(tile_0_3, 'White Tiger Island')).
:-assert(map_island_name(tile_2_2, 'Storm Reef')).
:-assert(map_island_name(tile_3_0, 'Northstable Island')).
:-assert(map_island_name(tile_4_5, 'Bishop Rock Island')).
:-assert(map_merchant_name(tile_0_3, 'Daniel Jacks')).
:-assert(map_merchant_name(tile_2_2, 'Tem')).
:-assert(map_merchant_name(tile_3_0, 'Morshu')).
:-assert(map_merchant_name(tile_4_5, 'Fred')).
:-assert(map_merchant_prompt(tile_0_3, 'My business was ruined by those pirate folk...')).
:-assert(map_merchant_prompt(tile_2_2, 'Tem go to colleg ye-ya!')).
:-assert(map_merchant_prompt(tile_3_0, 'Bomb, ropes, lamp oil. You want it? It''s yours my friend.')).
:-assert(map_merchant_prompt(tile_4_5, 'Good evening.')).
:-assert(map_merchant_topic(tile_0_3, merchants, 'If you''re brave enough, try east-northeast!')).
:-assert(map_merchant_topic(tile_2_2, merchants, 'sail eestwardz')).
:-assert(map_merchant_topic(tile_3_0, merchants, 'There are two other islands to the south-east.')).
:-assert(map_merchant_topic(tile_4_5, merchants, 'Other ships often take a course towards north...')).
:-assert(map_path(tile_0_0, e, tile_1_0)).
:-assert(map_path(tile_0_0, s, tile_0_1)).
:-assert(map_path(tile_0_1, e, tile_1_1)).
:-assert(map_path(tile_0_1, n, tile_0_0)).
:-assert(map_path(tile_0_1, s, tile_0_2)).
:-assert(map_path(tile_0_2, e, tile_1_2)).
:-assert(map_path(tile_0_2, n, tile_0_1)).
:-assert(map_path(tile_0_2, s, tile_0_3)).
:-assert(map_path(tile_0_3, e, tile_1_3)).
:-assert(map_path(tile_0_3, n, tile_0_2)).
:-assert(map_path(tile_0_3, s, tile_0_4)).
:-assert(map_path(tile_0_4, e, tile_1_4)).
:-assert(map_path(tile_0_4, n, tile_0_3)).
:-assert(map_path(tile_0_4, s, tile_0_5)).
:-assert(map_path(tile_0_5, e, tile_1_5)).
:-assert(map_path(tile_0_5, n, tile_0_4)).
:-assert(map_path(tile_1_0, e, tile_2_0)).
:-assert(map_path(tile_1_0, s, tile_1_1)).
:-assert(map_path(tile_1_0, w, tile_0_0)).
:-assert(map_path(tile_1_1, e, tile_2_1)).
:-assert(map_path(tile_1_1, n, tile_1_0)).
:-assert(map_path(tile_1_1, s, tile_1_2)).
:-assert(map_path(tile_1_1, w, tile_0_1)).
:-assert(map_path(tile_1_2, e, tile_2_2)).
:-assert(map_path(tile_1_2, n, tile_1_1)).
:-assert(map_path(tile_1_2, s, tile_1_3)).
:-assert(map_path(tile_1_2, w, tile_0_2)).
:-assert(map_path(tile_1_3, e, tile_2_3)).
:-assert(map_path(tile_1_3, n, tile_1_2)).
:-assert(map_path(tile_1_3, s, tile_1_4)).
:-assert(map_path(tile_1_3, w, tile_0_3)).
:-assert(map_path(tile_1_4, e, tile_2_4)).
:-assert(map_path(tile_1_4, n, tile_1_3)).
:-assert(map_path(tile_1_4, s, tile_1_5)).
:-assert(map_path(tile_1_4, w, tile_0_4)).
:-assert(map_path(tile_1_5, e, tile_2_5)).
:-assert(map_path(tile_1_5, n, tile_1_4)).
:-assert(map_path(tile_1_5, w, tile_0_5)).
:-assert(map_path(tile_2_0, e, tile_3_0)).
:-assert(map_path(tile_2_0, s, tile_2_1)).
:-assert(map_path(tile_2_0, w, tile_1_0)).
:-assert(map_path(tile_2_1, e, tile_3_1)).
:-assert(map_path(tile_2_1, n, tile_2_0)).
:-assert(map_path(tile_2_1, s, tile_2_2)).
:-assert(map_path(tile_2_1, w, tile_1_1)).
:-assert(map_path(tile_2_2, e, tile_3_2)).
:-assert(map_path(tile_2_2, n, tile_2_1)).
:-assert(map_path(tile_2_2, s, tile_2_3)).
:-assert(map_path(tile_2_2, w, tile_1_2)).
:-assert(map_path(tile_2_3, e, tile_3_3)).
:-assert(map_path(tile_2_3, n, tile_2_2)).
:-assert(map_path(tile_2_3, s, tile_2_4)).
:-assert(map_path(tile_2_3, w, tile_1_3)).
:-assert(map_path(tile_2_4, e, tile_3_4)).
:-assert(map_path(tile_2_4, n, tile_2_3)).
:-assert(map_path(tile_2_4, s, tile_2_5)).
:-assert(map_path(tile_2_4, w, tile_1_4)).
:-assert(map_path(tile_2_5, e, tile_3_5)).
:-assert(map_path(tile_2_5, n, tile_2_4)).
:-assert(map_path(tile_2_5, w, tile_1_5)).
:-assert(map_path(tile_3_0, e, tile_4_0)).
:-assert(map_path(tile_3_0, s, tile_3_1)).
:-assert(map_path(tile_3_0, w, tile_2_0)).
:-assert(map_path(tile_3_1, e, tile_4_1)).
:-assert(map_path(tile_3_1, n, tile_3_0)).
:-assert(map_path(tile_3_1, s, tile_3_2)).
:-assert(map_path(tile_3_1, w, tile_2_1)).
:-assert(map_path(tile_3_2, e, tile_4_2)).
:-assert(map_path(tile_3_2, n, tile_3_1)).
:-assert(map_path(tile_3_2, s, tile_3_3)).
:-assert(map_path(tile_3_2, w, tile_2_2)).
:-assert(map_path(tile_3_3, e, tile_4_3)).
:-assert(map_path(tile_3_3, n, tile_3_2)).
:-assert(map_path(tile_3_3, s, tile_3_4)).
:-assert(map_path(tile_3_3, w, tile_2_3)).
:-assert(map_path(tile_3_4, e, tile_4_4)).
:-assert(map_path(tile_3_4, n, tile_3_3)).
:-assert(map_path(tile_3_4, s, tile_3_5)).
:-assert(map_path(tile_3_4, w, tile_2_4)).
:-assert(map_path(tile_3_5, e, tile_4_5)).
:-assert(map_path(tile_3_5, n, tile_3_4)).
:-assert(map_path(tile_3_5, w, tile_2_5)).
:-assert(map_path(tile_4_0, e, tile_5_0)).
:-assert(map_path(tile_4_0, s, tile_4_1)).
:-assert(map_path(tile_4_0, w, tile_3_0)).
:-assert(map_path(tile_4_1, e, tile_5_1)).
:-assert(map_path(tile_4_1, n, tile_4_0)).
:-assert(map_path(tile_4_1, s, tile_4_2)).
:-assert(map_path(tile_4_1, w, tile_3_1)).
:-assert(map_path(tile_4_2, e, tile_5_2)).
:-assert(map_path(tile_4_2, n, tile_4_1)).
:-assert(map_path(tile_4_2, s, tile_4_3)).
:-assert(map_path(tile_4_2, w, tile_3_2)).
:-assert(map_path(tile_4_3, e, tile_5_3)).
:-assert(map_path(tile_4_3, n, tile_4_2)).
:-assert(map_path(tile_4_3, s, tile_4_4)).
:-assert(map_path(tile_4_3, w, tile_3_3)).
:-assert(map_path(tile_4_4, e, tile_5_4)).
:-assert(map_path(tile_4_4, n, tile_4_3)).
:-assert(map_path(tile_4_4, s, tile_4_5)).
:-assert(map_path(tile_4_4, w, tile_3_4)).
:-assert(map_path(tile_4_5, e, tile_5_5)).
:-assert(map_path(tile_4_5, n, tile_4_4)).
:-assert(map_path(tile_4_5, w, tile_3_5)).
:-assert(map_path(tile_5_0, s, tile_5_1)).
:-assert(map_path(tile_5_0, w, tile_4_0)).
:-assert(map_path(tile_5_1, n, tile_5_0)).
:-assert(map_path(tile_5_1, s, tile_5_2)).
:-assert(map_path(tile_5_1, w, tile_4_1)).
:-assert(map_path(tile_5_2, n, tile_5_1)).
:-assert(map_path(tile_5_2, s, tile_5_3)).
:-assert(map_path(tile_5_2, w, tile_4_2)).
:-assert(map_path(tile_5_3, n, tile_5_2)).
:-assert(map_path(tile_5_3, s, tile_5_4)).
:-assert(map_path(tile_5_3, w, tile_4_3)).
:-assert(map_path(tile_5_4, n, tile_5_3)).
:-assert(map_path(tile_5_4, s, tile_5_5)).
:-assert(map_path(tile_5_4, w, tile_4_4)).
:-assert(map_path(tile_5_5, n, tile_5_4)).
:-assert(map_path(tile_5_5, w, tile_4_5)).
:-assert(map_selling(tile_0_3, blunderbuss, 1.2)).
:-assert(map_selling(tile_0_3, gunpowder, 1.6)).
:-assert(map_selling(tile_0_3, mercenary, 1.0)).
:-assert(map_selling(tile_0_3, ration, 0.8)).
:-assert(map_selling(tile_0_3, rum, 1.2)).
:-assert(map_selling(tile_2_2, blunderbuss, 0.6)).
:-assert(map_selling(tile_2_2, gunpowder, 0.6)).
:-assert(map_selling(tile_2_2, map_piece_1, 1.0)).
:-assert(map_selling(tile_2_2, ration, 1.8)).
:-assert(map_selling(tile_2_2, rum, 1.4)).
:-assert(map_selling(tile_3_0, banana, 1.0)).
:-assert(map_selling(tile_3_0, blunderbuss, 1.0)).
:-assert(map_selling(tile_3_0, gunpowder, 1.0)).
:-assert(map_selling(tile_3_0, ration, 1.0)).
:-assert(map_selling(tile_3_0, rum, 1.0)).
:-assert(map_selling(tile_4_5, blunderbuss, 1.2)).
:-assert(map_selling(tile_4_5, gunpowder, 1.4)).
:-assert(map_selling(tile_4_5, mercenary, 0.8)).
:-assert(map_selling(tile_4_5, ration, 1.0)).
:-assert(map_selling(tile_4_5, rum, 1.2)).
:-assert(map_tile_type(tile_0_0, t_shallow)).
:-assert(map_tile_type(tile_0_1, t_shallow)).
:-assert(map_tile_type(tile_0_2, t_shallow)).
:-assert(map_tile_type(tile_0_3, t_merchant)).
:-assert(map_tile_type(tile_0_4, t_shallow)).
:-assert(map_tile_type(tile_0_5, t_shallow)).
:-assert(map_tile_type(tile_1_0, t_shallow)).
:-assert(map_tile_type(tile_1_1, t_deep)).
:-assert(map_tile_type(tile_1_2, t_deep)).
:-assert(map_tile_type(tile_1_3, t_deep)).
:-assert(map_tile_type(tile_1_4, t_deep)).
:-assert(map_tile_type(tile_1_5, t_shallow)).
:-assert(map_tile_type(tile_2_0, t_shallow)).
:-assert(map_tile_type(tile_2_1, t_deep)).
:-assert(map_tile_type(tile_2_2, t_merchant)).
:-assert(map_tile_type(tile_2_3, t_deep)).
:-assert(map_tile_type(tile_2_4, t_deep)).
:-assert(map_tile_type(tile_2_5, t_shallow)).
:-assert(map_tile_type(tile_3_0, t_merchant)).
:-assert(map_tile_type(tile_3_1, t_deep)).
:-assert(map_tile_type(tile_3_2, t_deep)).
:-assert(map_tile_type(tile_3_3, t_deep)).
:-assert(map_tile_type(tile_3_4, t_deep)).
:-assert(map_tile_type(tile_3_5, t_shallow)).
:-assert(map_tile_type(tile_4_0, t_shallow)).
:-assert(map_tile_type(tile_4_1, t_deep)).
:-assert(map_tile_type(tile_4_2, t_deep)).
:-assert(map_tile_type(tile_4_3, t_deep)).
:-assert(map_tile_type(tile_4_4, t_deep)).
:-assert(map_tile_type(tile_4_5, t_merchant)).
:-assert(map_tile_type(tile_5_0, t_shallow)).
:-assert(map_tile_type(tile_5_1, t_shallow)).
:-assert(map_tile_type(tile_5_2, t_shallow)).
:-assert(map_tile_type(tile_5_3, t_shallow)).
:-assert(map_tile_type(tile_5_4, t_shallow)).
:-assert(map_tile_type(tile_5_5, t_shallow)).
