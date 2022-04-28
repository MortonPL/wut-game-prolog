/*
╔══════════════════════════════╗
║ Filename: adventure_core.pl  ║
║ Title: Main game file.       ║
║ Reload: Forbidden            ║
╚══════════════════════════════╝
*/


/**SYSTEM
 * adv_add_inventory(+Object:atom, ++Amount:int)
 * 
 */
adv_add_inventory(Owner, Object, Amount) :-
        Amount > 0,
        assert(adv_in_inventory(Owner, Object)),
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
                ;
                retract(adv_in_inventory(Owner, Object)),
                retract(adv_in_inventory(Owner, Object, OldAmount))
        ).

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



/**COMMAND
 * take(Object)
 * 
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

handle_take_ret(Ret, Object, Amount) :-
        err_tooSmallAmount = Ret        -> write('Don''t be silly.~n');
        err_missingObject = Ret         -> format('There is none.~n');
        err_tooBigAmount = Ret          -> format('There is not enough ``~w'' here.~n', [Object]);
        ok_success = Ret                -> format('You took ~w of ''~w''.~n', [Amount, Object]).


/* These rules describe how to put down an object. */
drop(Object, Amount) :-
        adv_i_am_at(Place),
        (adv_move_inventory(player, Place, Object, Amount, Ret); true),
        handle_drop_ret(Ret, Object, Amount).

drop(Object) :-
        adv_in_inventory(player, Object, Amount),
        drop(Object, Amount),
        !.

drop(_) :-
        handle_drop_ret(err_missingObject, _, 0).

handle_drop_ret(Ret, Object, Amount) :-
        ok_success = Ret                -> format('You dropped ~w of ''~w''.~n', [Amount, Object]);
        err_missingObject = Ret         -> format('There is no ''~w'' on you.~n', [Object]);
        err_tooBigAmount = Ret          -> format('There is not enough ``~w'' on you.~n', [Object]);
        err_tooSmallAmount = Ret        -> write('Don''t be silly.~n').

/*WARNING - UNFORMATED, UNEDITED FILE */


/* These rules define the direction letters as calls to go/1. */
n() :- 
        go(n).
s() :- 
        go(s).
e() :- 
        go(e).
w() :- 
        go(w).


/* This rule tells how to move in a given direction. */
go(Direction) :-
        adv_i_am_at(Here),
        adv_path(Here, Direction, There),
        retract(adv_i_am_at(Here)),
        assert(adv_i_am_at(There)),
        !, look.

go(_) :-
        write('You can''t go that way.').


/* This rule tells how to look about you. */
look :-
        adv_i_am_at(Place),
        describe(),
        nl,
        notice_any_objects_at(Place),
        nl.

inventory :-
        nl,
        notice_any_objects_at(player),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */
notice_all_objects_at(Place) :-
        adv_in_inventory(Place, Object, Amount),
        format('~w of ''~w''~n', [Amount, Object]),       /* :kingsi: */
        fail.

notice_all_objects_at(_).


notice_any_objects_at(Place) :-
        (adv_in_inventory(Place, _, _) ->
                writeln('You can find following items:'),
                notice_all_objects_at(Place)
                ;
                writeln('There is nothing of value here.')
        ).  


/* This rule tells how to die. */
die :-
        finish.


/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */
finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.

/* This rule prints out instructions and tells where you are. */
game_start :-
        (retract(sys_first_session) ; true),
        !, look.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */
describe() :-
        adv_i_am_at(Place),
        desc_here(Place),
        format('You see:~n'),
        write(' - '), desc_horizon(Place, n, 'north'), format(',~n'),
        write(' - '), desc_horizon(Place, s, 'south'), format(',~n'),
        write(' - '), desc_horizon(Place, w, 'west'), format(',~n'),
        write(' - '), desc_horizon(Place, e, 'east'), format('.~n').

desc_here(Place) :-
        tile_type(Place, t_merchant) -> (
                name(Place, Name),
                format('You are on the ~w.~nThere ought to be a merchant here!~n', [Name])
        );
        tile_type(Place, t_shallow) -> format('You are on a calm sea.~n');
        tile_type(Place, t_deep) -> format('The sea is unsteady.~nYour ship could be blown away at any moment..~n').

desc_horizon(Place, Direction, DirName) :-
        adv_path(Place, Direction, OtherPlace) -> (
                tile_type(OtherPlace, t_merchant) -> format('a landmass up ~w', [DirName]);
                tile_type(OtherPlace, t_shallow) -> format('calm waters up ~w', [DirName]);
                tile_type(OtherPlace, t_deep) -> format('storm clouds forming up ~w', [DirName])
        );(
                format('nothing interesting up ~w', [DirName])
        ).