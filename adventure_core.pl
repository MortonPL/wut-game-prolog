/*
╔══════════════════════════════╗
║ Filename: adventure_core.pl  ║
║ Title: Main game file.       ║
╚══════════════════════════════╝
*/

:- [header].

% pragma once
:- has_included(adventure_core);assert(has_included(adventure_core)).

/**SYSTEM
 * adv_add_inventory(+Owner:atom, +Object:atom, ++Amount:int)
 * 
 * Adds or substracts an Amount of Object to an Owner's inventory.
 * Can fail?
 */
adv_add_inventory(Owner, Object, Amount) :-
        Amount > 0,
        (adv_in_inventory(Owner, Object, OldAmount) ->
                true
                ;
                OldAmount is 0
        ),
        (retract(adv_in_inventory(Owner, Object, OldAmount)) ; true),
        NewAmount is OldAmount + Amount,
        assert(adv_in_inventory(Owner, Object, NewAmount)).

adv_add_inventory(Owner, Object, Amount) :-
        Amount < 0,
        adv_in_inventory(Owner, Object, OldAmount),
        (OldAmount >= abs(Amount) -> 
                retract(adv_in_inventory(Owner, Object, OldAmount)),
                NewAmount is OldAmount + Amount,
                ((NewAmount > 0 -> assert(adv_in_inventory(Owner, Object, NewAmount))) ; true)
        ).


/**SYSTEM
 * adv_move_inventory(++OwnerA:atom, ++OwnerB:atom, ++Object:atom, ++Amount:int, --Ret:atom)
 * 
 * Transfers an Amount of Object from OwnerA to OwnerB. Result of this action is stored in Ret.
 * Doesn't fail.
 */
adv_move_inventory(OwnerA, OwnerB, Object, Amount, Ret) :-
        Amount > 0 -> (
                adv_in_inventory(OwnerA, Object, AmountA) -> (
                        AmountA >= Amount -> (
                                Ret = ok_success,
                                adv_add_inventory(OwnerA, Object, -Amount),
                                adv_add_inventory(OwnerB, Object, Amount)
                        ) ; Ret = err_tooBigAmount
                ) ; Ret = err_missingObject
        ); Ret = err_tooSmallAmount.

has_at_least(Owner, Object, Amount) :-
        adv_in_inventory(Owner, Object, ActualAmount),
        ActualAmount >= Amount.

/**COMMAND
 * take(++Object:atom, ++Amount:int)
 * 
 * Picks up an Amount of Object from the current location, if it is possible.
 * Can fail.
 */
take(Object, Amount) :-
        adv_i_am_at(Place),
        adv_move_inventory(Place, player, Object, Amount, Ret),
        handle_take_ret(Ret, Object, Amount),
        !.

take(Object) :-
        adv_i_am_at(Place),
        adv_in_inventory(Place, Object, Amount),
        take(Object, Amount),
        !.

take(_) :-
        handle_take_ret(err_missingObject, _, 0).


/**HELPER
 * handle_take_ret(++Ret:atom, ++Object:atom, ++Amount:int)
 * 
 * Informs the user of the result of 'take' command.
 */
handle_take_ret(Ret, Object, Amount) :-
        err_tooSmallAmount = Ret        -> writeln('You can''t take less than 1 of something.');
        err_missingObject = Ret         -> format('There is none.~n');
        err_tooBigAmount = Ret          -> format('There is not enough ''~w'' here.~n', [Object]);
        ok_success = Ret                -> format('You took ~w of ''~w''.~n', [Amount, Object]).


/**COMMAND
 * drop(++Object:atom, ++Amount:int)
 * 
 * Drops down an Amount of Object from the current location, if it is possible.
 * Can fail.
 */
drop(Object, Amount) :-
        adv_i_am_at(Place),
        (adv_move_inventory(player, Place, Object, Amount, Ret); true),
        handle_drop_ret(Ret, Object, Amount),
        !.

drop(Object) :-
        adv_in_inventory(player, Object, Amount),
        drop(Object, Amount),
        !.

drop(_) :-
        handle_drop_ret(err_missingObject, _, 0).


/**HELPER
 * handle_drop_ret(++Ret:atom, ++Object:atom, ++Amount:int)
 * 
 * Informs the user of the result of 'drop' command.
 */
handle_drop_ret(Ret, Object, Amount) :-
        ok_success = Ret                -> format('You dropped ~w of ''~w''.~n', [Amount, Object]);
        err_missingObject = Ret         -> format('There is no ''~w'' on you.~n', [Object]);
        err_tooBigAmount = Ret          -> format('There is not enough ''~w'' on you.~n', [Object]);
        err_tooSmallAmount = Ret        -> write('Don''t be silly.~n').


/**COMMAND
 * sell(++Merchant:atom, ++Object:int, ++Amount:int)
 *
 * Sells Amount of Object from player's inventory to Merchant for coins.
 * Fails if player has no specified Amount of Object or the Amount is non-positive.
 *
 * Merchants are programmed to have no inventory (their resources are unlimited).
 */
sell(Merchant, Object, Amount) :-
        (Amount > 0 -> true;
                report_trading_error(err_negativeAmount, Object)),
        map_merchant_name(Place, Merchant),
        adv_i_am_at(Place),
        adv_price(Object, BasePrice),
        (map_buying(Place, Object, PriceMultiplier) -> true;
                report_trading_error(err_notBuying, Object)),
        EarnedCoins is Amount * round(BasePrice * PriceMultiplier),
        (has_at_least(player, Object, Amount) -> true;
                report_trading_error(err_notEnoughGoods, Object)),
        adv_add_inventory(player, Object, -Amount),
        adv_add_inventory(player, coin, EarnedCoins),
        format('You sold ~w of ''~w'' for ~w coins.~n', [Amount, Object, EarnedCoins]),
        !.

/**COMMAND
 * buy(++Merchant:atom, ++Object:int, ++Amount:int)
 *
 * Buys Amount of Object from Merchant for coins and places it in player's inventory.
 * Fails if player has not enought money or the Amount is non-positive.
 *
 * Merchants are programmed to have no inventory (their resources are unlimited).
 */
buy(Merchant, Object, Amount) :-
        (Amount > 0 -> true;
                report_trading_error(err_negativeAmount, Object)),
        map_merchant_name(Place, Merchant),
        adv_i_am_at(Place),
        adv_price(Object, BasePrice),
        (map_selling(Place, Object, PriceMultiplier) -> true;
                report_trading_error(err_notSelling, Object)),
        SpentCoins is Amount * round(BasePrice * PriceMultiplier),
        (has_at_least(player, coin, SpentCoins) -> true;
                report_trading_error(err_noMoney, Object)),
        adv_add_inventory(player, coin, -SpentCoins),
        adv_add_inventory(player, Object, Amount),
        format('You bought ~w of ''~w'' for ~w coins.~n', [Amount, Object, SpentCoins]),
        !.

/**HELPER
 * report_trading_error(++Error:atom, ++Object:atom)
 *
 * Prints out defined error messages.
 * Always fails.
 */
report_trading_error(Error, Object) :-
        (Error = err_noMoney       -> writeln('Come back when you''re a little richer.');
        Error = err_notEnoughGoods -> format('There is not enough ''~w'' on you.~n', [Object]);
        Error = err_notSelling     -> format('You can''t buy ''~w'' here.~n', [Object]);
        Error = err_notBuying      -> format('You can''t sell ''~w'' here.~n', [Object]);
        Error = err_negativeAmount -> writeln('No cheating >.<')),
        fail.


/*WARNING - UNFORMATED, UNEDITED FILE */


/**COMMAND
 * north() / n() / south() / s() / east() / e() / west() / w()
 * 
 * User command aliases for moving in one of the cardinal directions.
 */
north() :-
        go(n).

n() :- 
        north.

south() :-
        go(s).

s() :- 
        south.

east() :-
        go(e).

e() :- 
        east.

west() :-
        go(w).

w() :- 
        west.


/**SYSTEM
 * go(+Direction:atom)
 * 
 * Change player's location to a neighbouring tile in a Direction if possible.
 * Can fail.
 */
go(Direction) :-
        move(Direction),
        !,
        check_storm(Direction),
        pirate_roll,
        look.

go(_) :-
        write('You can''t go that way.').

/**HELPER
 * move(++Direction: [n, s, w, e])
 * 
 * Moves the player in specific direction if possible.
 */
move(Direction) :-
        adv_i_am_at(Here),
        map_path(Here, Direction, There),
        retract(adv_i_am_at(Here)),
        assert(adv_i_am_at(There)).

/**SYSTEM
 * check_storm(++Direction: [n, s, w, e])
 * 
 * Performs a storm if conditions are met.
 */
check_storm(Direction) :-
        adv_i_am_at(Position),
        map_tile_type(Position, t_deep),
        random_between(1, 30, Rand),
        Rand =< 10 ->
        do_the_storm(Direction);
        true.

/**HELPER
 * do_the_storm(++Direction: [n, s, w, e])
 * 
 * Performs the storm by moving a player in random direction that is not canceling his last move.
 */
do_the_storm(Direction) :-
        dir_encode(Direction, Value),
        random_between(-1, 1, Rand),
        NewValue is (Value + Rand) mod 4,
        dir_decode(NewDirection, NewValue),
        format('A storm went by, your ship is off the course!~n~n'),
        move(NewDirection).

/**HELPER
 * dir_encode(++Direction: [n, s, w, e], --Value:int)
 * 
 * Turns direction into integer.
 */
dir_encode(Direction, Value) :-
        Direction = n -> Value is 0;
        Direction = e -> Value is 1;
        Direction = s -> Value is 2;
        Direction = w -> Value is 3.

/**HELPER
 * dir_decode(--Direction: [n, s, w, e], ++Value:int)
 * 
 * Turns integer into direction.
 */
dir_decode(Direction, Value) :-
        Value is 0 -> Direction = n;
        Value is 1 -> Direction = e;
        Value is 2 -> Direction = s;
        Value is 3 -> Direction = w.


/**COMMAND
 * inventory() / i()
 * 
 * Print the list of player owned objects and their amounts.
 */
inventory :-
        nl,
        notice_any_objects_at(player),
        nl.

i :- inventory.


/**SYSTEM
 * notice_any_objects_at(+Place:atom)
 * 
 * Lists all objects in a Place or, if nothing is found, says so.
 * Doesn't fail.
 */
notice_any_objects_at(Place) :-
        (adv_in_inventory(Place, _, _) ->
                writeln('You can find following items:'),
                notice_all_objects_at(Place)
                ;
                writeln('  - There is nothing of value here.')
        ). 

/**HELPER
 * notice_any_objects_at(+Place:atom)
 * 
 * Goes over all possible objects in the Place and prints them.
 * Failure-driven loop.
 */
notice_all_objects_at(Place) :-
        adv_in_inventory(Place, Object, Amount),
        format('  - ~w of ''~w''~n', [Amount, Object]),
        fail.

notice_all_objects_at(_). 


/**SYSTEM
 * game_start()
 * 
 * Begins the game session.
 */
game_start :-
        (retract(sys_first_session) ; true),
        !, look.


/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */
finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.


/**COMMAND
 * look()
 * 
 * Print the description of the current and neighbouring locations.
 */
look() :-
        adv_i_am_at(Place),
        writeln('[~~~~~~~~~~~~~~~~~ DAILY REPORT ~~~~~~~~~~~~~~~~~~ (''helpme.'' to get help) ~~~~]'),
        writeln('Your first mate reports:'),
        desc_here(Place),
        nl,
        writeln('Your foretopman reports:'),
        desc_horizon(Place, n, 'north'), format(',~n'),
        desc_horizon(Place, s, 'south'), format(',~n'),
        desc_horizon(Place, w, 'west'), format(',~n'),
        desc_horizon(Place, e, 'east'), format('.~n'),
        nl,
        writeln('Your merchant''s intuition says:'),
        notice_any_objects_at(Place).

/**HELPER
 * desc_here(++Place:atom)
 * 
 * Describes the Place.
 * Doesn't fail.
 */
desc_here(Place) :-
        map_tile_type(Place, t_merchant) -> (
                map_island_name(Place, Name),
                map_merchant_name(Place, Merchant),
                format('  - You are on the ~w.~n  - Rumours are you can trade with ~w here. You gotta ask them.~n', [Name, Merchant])
        );
        map_tile_type(Place, t_shallow) -> format('  - You are on a calm sea.~n');
        map_tile_type(Place, t_deep) -> format('  - The sea is unsteady.~n  - Your ship could be blown away at any moment..~n').

/**HELPER
 * desc_horizon(+Place:atom, +Direction, +DirName)
 * 
 * Describes the neighbour of Place in a Direction, called DirName.
 * Doesn't fail.
 */
desc_horizon(Place, Direction, DirName) :-
        map_path(Place, Direction, OtherPlace) -> (
                map_tile_type(OtherPlace, t_merchant) -> format('  - Land ho! A coast up ~w', [DirName]);
                map_tile_type(OtherPlace, t_shallow) -> format('  - Nothing but calm waters up ~w', [DirName]);
                map_tile_type(OtherPlace, t_deep) -> format('  - Vile storms are brewing up ~w', [DirName])
        );(
                format('  - No money to be made up ~w', [DirName])
        ).

/**HELPER
 * adv_items_reduce(++Percentage:float)
 * 
 * Keeps only the provided percentage of items on the player.
 * Rounds to the bottom. (stacks of 1 disappear)
 */
adv_items_reduce(Percentage) :-
        adv_in_inventory(player, Item, Count),
        Remove is floor(Count * Percentage) - Count,
        adv_add_inventory(player, Item, Remove),
        fail.

adv_items_reduce(_).

/**HELPER
 * ensure_map_piece_1()
 * 
 * Give the player a map piece 1 if he doesn't have one yet.
 */
ensure_map_piece_1() :-
        (\+ adv_in_inventory(player, map_piece_1, _)) ->
        adv_add_inventory(player, map_piece_1, 1),
        format('You''ve found a map piece in the wreckage!~n'),
        !;
        true.

/**SYSTEM
 * pirate_attack()
 * 
 * Simulates a pirate attack.
 */
pirate_attack() :-
        format('The pirates attacked you!~n'),
        adv_add_inventory(player, mercenary, -1) ->
                format('Your brave mercenaries defended you!~n(-1 mercenary)~n~n'),
                ensure_map_piece_1
        ;
                adv_items_reduce(0.5),
                format('You had no one to defend.~nYou lost half of your items.~n~n').

/**SYSTEM
 * pirate_roll()
 * 
 * Rolls for a pirate attack and performs it if conditions are met.
 */
pirate_roll() :-
        total_worth(TotalWorth),
        pirates_min_th(MinTreshold),
        TotalWorth > MinTreshold -> (
                pirates_max_th(MaxTreshold),
                pirates_max_pc(MaxRisk),
                Risk is MaxRisk * (min(TotalWorth, MaxTreshold) - MinTreshold) / (MaxTreshold - MinTreshold),
                random(Rand),
                Risk > Rand ->
                pirate_attack();
                true
        );
        true.

/**HELPER
 * total_worth(--TotalWorth:int)
 * 
 * Calculates the total worth of player ship.
 */
total_worth(TotalWorth) :-
        findall([Item, Count], (adv_in_inventory(player, Item, Count)), Items),
        worth_sum(Items, TotalWorth).

/**HELPER
 * worth_sum(++[Head|Tail]:[Item, Count][], --TotalWorth:int)
 * 
 * Calculates a partial worth of player ship.
 */
worth_sum([], 0).
worth_sum([Head|Tail], TotalWorth) :-
        worth_sum(Tail, Rest),
        nth0(0, Head, Item),
        nth0(1, Head, Count),
        adv_worth(Item, Worth),
        TotalWorth is (Count * Worth) + Rest.

/**COMMAND
 * ask(++Merchant:atom, ++Topic:atom)
 * 
 * Lists available topics player can talk about with Merchant.
 */
ask(Merchant) :-
        map_merchant_name(Place, Merchant),
        (adv_i_am_at(Place) -> true; format('Unfortunately, ~w is far away.~n', [Merchant]), fail),
        writeln('What do you want to ask about?'),
        write('''offer'''),
        (Merchant = 'Tem' -> write(' ''map'''); true),
        print_out_topics(Place),
        true.

print_out_topics(Place) :-
        map_merchant_topic(Place, Topic, _),
        format(' ''~w''', [Topic]),
        fail.

print_out_topics(_). 

/**COMMAND
 * ask(++Merchant:atom, ++Topic:atom)
 * 
 * Provides information on Topic from Merchant's perspective.
 */
ask(Merchant, Topic) :-
        map_merchant_name(Place, Merchant),
        (adv_i_am_at(Place) -> true; format('Unfortunately, ~w is far away.~n', [Merchant]), fail),
        (Topic = offer -> print_out_offer(Place);
                map_merchant_topic(Place, Topic, Answer) -> writeln(Answer);
                (Merchant = 'Tem', Topic = map) -> check_mq_status;
                writeln('Haven''t heard of it.')
        ).

check_mq_status :-
        ((adv_in_inventory(player, map_piece_1, _), adv_in_inventory(player, map_piece_2, _))
                -> (writeln('Well done :3 You win.'), halt);
        (adv_in_inventory(player, map_piece_1, _); adv_in_inventory(player, map_piece_2, _))
                -> writeln('u need one more piece');
        writeln('what map?')).

/**HELPER
 * print_out_offer(++Place:atom)
 * 
 * Prints out trade offers from Place.
 */
print_out_offer(Place) :-
        map_merchant_prompt(Place, Prompt),
        writeln(Prompt),
        writeln('[Selling]'),
        print_selling_offer(Place),
        nl,
        writeln('[Buying]'),
        print_buying_offer(Place),
        true.

/**HELPER
 * print_selling_offer(+Place:atom)
 * 
 * Failure-driven loop for map_selling facts with fixed Place.
 */
print_selling_offer(Place) :-
        map_selling(Place, Object, PriceMultiplier),
        adv_price(Object, BasePrice),
        MultipliedPrice is round(BasePrice * PriceMultiplier),
        format('''~w'' for ~w coins each~n', [Object, MultipliedPrice]),
        fail.

print_selling_offer(_). 

/**HELPER
 * print_buying_offer(+Place:atom)
 * 
 * Failure-driven loop for map_buying facts with fixed Place.
 */
print_buying_offer(Place) :-
        map_buying(Place, Object, PriceMultiplier),
        adv_price(Object, BasePrice),
        MultipliedPrice is round(BasePrice * PriceMultiplier),
        format('''~w'' for ~w coins each~n', [Object, MultipliedPrice]),
        fail.

print_buying_offer(_). 

/**COMMAND
 * inspect(Item)
 * 
 * Tells you something about an item that you own.
 */
inspect(Item) :-
        (\+ adv_in_inventory(player, Item, _)) ->
        format('You don''t own that sort of item.');
        Item = rum -> format('Would be delicious with cola, if I knew what that was.');
        Item = gunpowder -> format('If you ever get sick of water just blow it up!');
        Item = blunderbuss -> format('But I like to call it the Blunderbussy.');
        Item = ration -> format('Meat so dry you can rip pants with it.');
        Item = banana -> format('You know what a banana is, but did you know it can rotate?');
        Item = map_piece_1 -> format('A map piece that appears to be torn in half.~nMaybe I can find the other piece if I ask merchants?');
        Item = map_piece_2 -> format('A map piece that appears to be torn in half.~nMaybe the pirates know something about the other piece?');
        Item = mercenary -> format('The power of Sun Tzu in the palm of your hand.~nReduces pirate attacks and deflects them.');
        Item = coin -> format('Local currency.~nI think it''s named ''Kromer''?').
