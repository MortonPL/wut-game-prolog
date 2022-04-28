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
        (OldAmount > abs(Amount) ->
                retract(adv_in_inventory(Owner, Object, OldAmount)),
                NewAmount is OldAmount + Amount,
                assert(adv_in_inventory(Owner, Object, NewAmount))
                ;
                retract(adv_in_inventory(Owner, Object)),
                retract(adv_in_inventory(Owner, Object, OldAmount))
        ).


/**COMMAND
 * take(Object)
 * 
 */
take(Object) :-
        adv_i_am_at(Place),
        adv_in_inventory(Place, Object),
        retract(adv_at(Object, Place)),
        adv_add_inventory(Place, Object, -1),
        adv_add_inventory(player, Object, 1),
        write('OK.'),
        !, nl.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */
drop(Object) :-
        adv_in_inventory(player, Object),
        adv_i_am_at(Place),
        adv_add_inventory(player, Object, -1),
        adv_add_inventory(Place, Object, 1),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You don''t have any '),
        write(_),
        write('!'),
        nl.


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


/* These rules set up a loop to mention all the objects
   in your vicinity. */
notice_all_objects_at(Place) :-
        adv_in_inventory(Place, Object, Amount),
        write(Object),write('('),write(Amount),write(').'),nl,
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

