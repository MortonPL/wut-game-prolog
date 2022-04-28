/*
╔════════════════════════════════╗
║ Filename: adventure_new.pl     ║
║ Title: Fresh game start state. ║
║ Reload: Unsafe                 ║
╚════════════════════════════════╝
*/

% Default starting game state / scenario.

adv_i_am_at(someplace).

adv_path(someplace, n, someplace).

adv_in_inventory(someplace, thing, 5).
adv_in_inventory(someplace, thing2, 3).
