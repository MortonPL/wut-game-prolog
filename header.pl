/*
╔═════════════════════════════════════╗
║ Filename: header.pl                 ║
║ Title: Forward declarations         ║
╚═════════════════════════════════════╝
*/

% adventure_core
        % data
        :- dynamic adv_i_am_at/1,       adv_in_inventory/2, adv_in_inventory/3, adv_player_name/1,
                   map_path/3,          map_merchandise/3,  map_name/2,         map_tile_type/2,
                   map_merchant_name/2.

        % functors
        :- dynamic adv_add_inventory/3,     adv_move_inventory/5, take/1,           take/2,
                   handle_take_ret/3,       drop/2,               drop/1,           handle_drop_ret/3,
                   north/0, n/0,            south/0, s/0,         east/0, e/0,      west/0, w/0,
                   go/1,                    look/0,               inventory/0, i/0, notice_all_objects_at/1,
                   notice_any_objects_at/1, die/0,                finish/0,         game_start/0,
                   describe/0,              desc_here/1,          desc_horizon/3.

% adventure
        % data
        :- dynamic sys_first_session/0.

        % functors
        :- dynamic start/0, quit/0, menu/0.


% command
        % data
        :- dynamic command/1.

        % functors
        :- dynamic confirm/1, get_input/3, get_input/4.


% helpme
        % functors
        :- dynamic helpme/0, helpme/1, get_description/1.


% serialize
        % data
        :- dynamic serializable/1, sys_last_savename/1.

        % functors
        :- dynamic serializables/1, save/0, save/1, load/0, load/1, reset_game/0.
