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
        err(Amount > 0, Ret, err_tooSmallAmount),
        err(adv_in_inventory(OwnerA, Object, AmountA), Ret, err_missingObject),
        err(AmountA >= Amount, Ret, err_tooBigAmount),
        ok(Ret),
        adv_add_inventory(OwnerA, Object, -Amount),
        adv_add_inventory(OwnerB, Object, Amount).

err(Cond, Ret, RetVal) :-
        (\+ Cond) -> Ret = RetVal.

ok(Ret) :-
        Ret = ok_success.



/**COMMAND
 * take(Object)
 * 
 */
take(Object, Amount) :-
        adv_i_am_at(Place),
        (adv_move_inventory(Place, player, Object, Amount, Ret); true),
        handle_take_ret(Ret, Object, Amount).

take(Object) :-
        adv_i_am_at(Place),
        adv_in_inventory(Place, Object, Amount),
        take(Object, Amount),
        !.

take(_) :-
        handle_take_ret(err_missingObject, _, 0).

handle_take_ret(Ret, Object, Amount) :-
        ok_success = Ret                -> format('You took ~w of ''~w''.~n', [Amount, Object]);
        err_missingObject = Ret         -> format('There is no ''~w'' here.~n', [Object]);
        err_tooBigAmount = Ret          -> format('There is not enough ``~w'' here.~n', [Object]);
        err_tooSmallAmount = Ret        -> write('Don''t be silly.~n').


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
        describe(Place),
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
describe(someplace) :- write('You are someplace.'), nl.

