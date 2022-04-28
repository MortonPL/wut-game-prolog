% Tiles
assert(tile_type(tile_0_0, t_deep)).
assert(tile_type(tile_0_1, t_deep)).
assert(tile_type(tile_0_2, t_deep)).
assert(tile_type(tile_0_3, t_merchant)).
assert(merchandise(tile_0_3, rum, 1.2)).
assert(merchandise(tile_0_3, gunpowder, 1.6)).
assert(merchandise(tile_0_3, blunderbuss, 1.2)).
assert(merchandise(tile_0_3, ration, 0.8)).
assert(name("White Tiger Island")).
assert(tile_type(tile_0_4, t_deep)).
assert(tile_type(tile_0_5, t_deep)).
assert(tile_type(tile_1_0, t_deep)).
assert(tile_type(tile_1_1, t_deep)).
assert(tile_type(tile_1_2, t_deep)).
assert(tile_type(tile_1_3, t_deep)).
assert(tile_type(tile_1_4, t_deep)).
assert(tile_type(tile_1_5, t_deep)).
assert(tile_type(tile_2_0, t_deep)).
assert(tile_type(tile_2_1, t_deep)).
assert(tile_type(tile_2_2, t_merchant)).
assert(merchandise(tile_2_2, rum, 1.4)).
assert(merchandise(tile_2_2, gunpowder, 0.6)).
assert(merchandise(tile_2_2, blunderbuss, 0.6)).
assert(merchandise(tile_2_2, ration, 1.8)).
assert(name("Storm Reef")).
assert(tile_type(tile_2_3, t_deep)).
assert(tile_type(tile_2_4, t_deep)).
assert(tile_type(tile_2_5, t_deep)).
assert(tile_type(tile_3_0, t_merchant)).
assert(merchandise(tile_3_0, rum, 1.0)).
assert(merchandise(tile_3_0, gunpowder, 1.0)).
assert(merchandise(tile_3_0, blunderbuss, 1.0)).
assert(merchandise(tile_3_0, ration, 1.0)).
assert(name("Northstable Island")).
assert(tile_type(tile_3_1, t_deep)).
assert(tile_type(tile_3_2, t_deep)).
assert(tile_type(tile_3_3, t_deep)).
assert(tile_type(tile_3_4, t_deep)).
assert(tile_type(tile_3_5, t_deep)).
assert(tile_type(tile_4_0, t_deep)).
assert(tile_type(tile_4_1, t_deep)).
assert(tile_type(tile_4_2, t_deep)).
assert(tile_type(tile_4_3, t_deep)).
assert(tile_type(tile_4_4, t_deep)).
assert(tile_type(tile_4_5, t_merchant)).
assert(merchandise(tile_4_5, rum, 1.2)).
assert(merchandise(tile_4_5, gunpowder, 1.4)).
assert(merchandise(tile_4_5, blunderbuss, 1.2)).
assert(merchandise(tile_4_5, ration, 1.0)).
assert(name("Bishop Rock Island")).
assert(tile_type(tile_5_0, t_deep)).
assert(tile_type(tile_5_1, t_deep)).
assert(tile_type(tile_5_2, t_deep)).
assert(tile_type(tile_5_3, t_deep)).
assert(tile_type(tile_5_4, t_deep)).
assert(tile_type(tile_5_5, t_shallow)).
% Paths
assert(adv_path(tile_1_0, w, tile_0_0)).
assert(adv_path(tile_1_1, w, tile_0_1)).
assert(adv_path(tile_1_2, w, tile_0_2)).
assert(adv_path(tile_1_3, w, tile_0_3)).
assert(adv_path(tile_1_4, w, tile_0_4)).
assert(adv_path(tile_1_5, w, tile_0_5)).
assert(adv_path(tile_2_0, w, tile_1_0)).
assert(adv_path(tile_2_1, w, tile_1_1)).
assert(adv_path(tile_2_2, w, tile_1_2)).
assert(adv_path(tile_2_3, w, tile_1_3)).
assert(adv_path(tile_2_4, w, tile_1_4)).
assert(adv_path(tile_2_5, w, tile_1_5)).
assert(adv_path(tile_3_0, w, tile_2_0)).
assert(adv_path(tile_3_1, w, tile_2_1)).
assert(adv_path(tile_3_2, w, tile_2_2)).
assert(adv_path(tile_3_3, w, tile_2_3)).
assert(adv_path(tile_3_4, w, tile_2_4)).
assert(adv_path(tile_3_5, w, tile_2_5)).
assert(adv_path(tile_4_0, w, tile_3_0)).
assert(adv_path(tile_4_1, w, tile_3_1)).
assert(adv_path(tile_4_2, w, tile_3_2)).
assert(adv_path(tile_4_3, w, tile_3_3)).
assert(adv_path(tile_4_4, w, tile_3_4)).
assert(adv_path(tile_4_5, w, tile_3_5)).
assert(adv_path(tile_5_0, w, tile_4_0)).
assert(adv_path(tile_5_1, w, tile_4_1)).
assert(adv_path(tile_5_2, w, tile_4_2)).
assert(adv_path(tile_5_3, w, tile_4_3)).
assert(adv_path(tile_5_4, w, tile_4_4)).
assert(adv_path(tile_5_5, w, tile_4_5)).
assert(adv_path(tile_0_0, e, tile_1_0)).
assert(adv_path(tile_0_1, e, tile_1_1)).
assert(adv_path(tile_0_2, e, tile_1_2)).
assert(adv_path(tile_0_3, e, tile_1_3)).
assert(adv_path(tile_0_4, e, tile_1_4)).
assert(adv_path(tile_0_5, e, tile_1_5)).
assert(adv_path(tile_1_0, e, tile_2_0)).
assert(adv_path(tile_1_1, e, tile_2_1)).
assert(adv_path(tile_1_2, e, tile_2_2)).
assert(adv_path(tile_1_3, e, tile_2_3)).
assert(adv_path(tile_1_4, e, tile_2_4)).
assert(adv_path(tile_1_5, e, tile_2_5)).
assert(adv_path(tile_2_0, e, tile_3_0)).
assert(adv_path(tile_2_1, e, tile_3_1)).
assert(adv_path(tile_2_2, e, tile_3_2)).
assert(adv_path(tile_2_3, e, tile_3_3)).
assert(adv_path(tile_2_4, e, tile_3_4)).
assert(adv_path(tile_2_5, e, tile_3_5)).
assert(adv_path(tile_3_0, e, tile_4_0)).
assert(adv_path(tile_3_1, e, tile_4_1)).
assert(adv_path(tile_3_2, e, tile_4_2)).
assert(adv_path(tile_3_3, e, tile_4_3)).
assert(adv_path(tile_3_4, e, tile_4_4)).
assert(adv_path(tile_3_5, e, tile_4_5)).
assert(adv_path(tile_4_0, e, tile_5_0)).
assert(adv_path(tile_4_1, e, tile_5_1)).
assert(adv_path(tile_4_2, e, tile_5_2)).
assert(adv_path(tile_4_3, e, tile_5_3)).
assert(adv_path(tile_4_4, e, tile_5_4)).
assert(adv_path(tile_4_5, e, tile_5_5)).
assert(adv_path(tile_5_0, e, tile_6_0)).
assert(adv_path(tile_5_1, e, tile_6_1)).
assert(adv_path(tile_5_2, e, tile_6_2)).
assert(adv_path(tile_5_3, e, tile_6_3)).
assert(adv_path(tile_5_4, e, tile_6_4)).
assert(adv_path(tile_5_5, e, tile_6_5)).
assert(adv_path(tile_0_1, n, tile_0_0)).
assert(adv_path(tile_0_2, n, tile_0_1)).
assert(adv_path(tile_0_3, n, tile_0_2)).
assert(adv_path(tile_0_4, n, tile_0_3)).
assert(adv_path(tile_0_5, n, tile_0_4)).
assert(adv_path(tile_1_1, n, tile_1_0)).
assert(adv_path(tile_1_2, n, tile_1_1)).
assert(adv_path(tile_1_3, n, tile_1_2)).
assert(adv_path(tile_1_4, n, tile_1_3)).
assert(adv_path(tile_1_5, n, tile_1_4)).
assert(adv_path(tile_2_1, n, tile_2_0)).
assert(adv_path(tile_2_2, n, tile_2_1)).
assert(adv_path(tile_2_3, n, tile_2_2)).
assert(adv_path(tile_2_4, n, tile_2_3)).
assert(adv_path(tile_2_5, n, tile_2_4)).
assert(adv_path(tile_3_1, n, tile_3_0)).
assert(adv_path(tile_3_2, n, tile_3_1)).
assert(adv_path(tile_3_3, n, tile_3_2)).
assert(adv_path(tile_3_4, n, tile_3_3)).
assert(adv_path(tile_3_5, n, tile_3_4)).
assert(adv_path(tile_4_1, n, tile_4_0)).
assert(adv_path(tile_4_2, n, tile_4_1)).
assert(adv_path(tile_4_3, n, tile_4_2)).
assert(adv_path(tile_4_4, n, tile_4_3)).
assert(adv_path(tile_4_5, n, tile_4_4)).
assert(adv_path(tile_5_1, n, tile_5_0)).
assert(adv_path(tile_5_2, n, tile_5_1)).
assert(adv_path(tile_5_3, n, tile_5_2)).
assert(adv_path(tile_5_4, n, tile_5_3)).
assert(adv_path(tile_5_5, n, tile_5_4)).
assert(adv_path(tile_0_0, s, tile_0_1)).
assert(adv_path(tile_0_1, s, tile_0_2)).
assert(adv_path(tile_0_2, s, tile_0_3)).
assert(adv_path(tile_0_3, s, tile_0_4)).
assert(adv_path(tile_0_4, s, tile_0_5)).
assert(adv_path(tile_0_5, s, tile_0_6)).
assert(adv_path(tile_1_0, s, tile_1_1)).
assert(adv_path(tile_1_1, s, tile_1_2)).
assert(adv_path(tile_1_2, s, tile_1_3)).
assert(adv_path(tile_1_3, s, tile_1_4)).
assert(adv_path(tile_1_4, s, tile_1_5)).
assert(adv_path(tile_1_5, s, tile_1_6)).
assert(adv_path(tile_2_0, s, tile_2_1)).
assert(adv_path(tile_2_1, s, tile_2_2)).
assert(adv_path(tile_2_2, s, tile_2_3)).
assert(adv_path(tile_2_3, s, tile_2_4)).
assert(adv_path(tile_2_4, s, tile_2_5)).
assert(adv_path(tile_2_5, s, tile_2_6)).
assert(adv_path(tile_3_0, s, tile_3_1)).
assert(adv_path(tile_3_1, s, tile_3_2)).
assert(adv_path(tile_3_2, s, tile_3_3)).
assert(adv_path(tile_3_3, s, tile_3_4)).
assert(adv_path(tile_3_4, s, tile_3_5)).
assert(adv_path(tile_3_5, s, tile_3_6)).
assert(adv_path(tile_4_0, s, tile_4_1)).
assert(adv_path(tile_4_1, s, tile_4_2)).
assert(adv_path(tile_4_2, s, tile_4_3)).
assert(adv_path(tile_4_3, s, tile_4_4)).
assert(adv_path(tile_4_4, s, tile_4_5)).
assert(adv_path(tile_4_5, s, tile_4_6)).
assert(adv_path(tile_5_0, s, tile_5_1)).
assert(adv_path(tile_5_1, s, tile_5_2)).
assert(adv_path(tile_5_2, s, tile_5_3)).
assert(adv_path(tile_5_3, s, tile_5_4)).
assert(adv_path(tile_5_4, s, tile_5_5)).
assert(adv_path(tile_5_5, s, tile_5_6)).
