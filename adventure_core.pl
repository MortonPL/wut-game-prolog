/*
╔══════════════════════════════╗
║ Filename: adventure_core.pl  ║
║ Title: Main game file.       ║
║ Reload: Forbidden            ║
╚══════════════════════════════╝
*/

/*WARNING - UNFORMATED, UNEDITED FILE */

/* These rules describe how to pick up an object. */
take(X) :-
        adv_holding(X),
        write('You''re already holding it!'),
        !, nl.

take(X) :-
        adv_i_am_at(Place),
        adv_at(X, Place),
        retract(adv_at(X, Place)),
        assert(adv_holding(X)),
        write('OK.'),
        !, nl.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */
drop(X) :-
        adv_holding(X),
        adv_i_am_at(Place),
        retract(adv_holding(X)),
        assert(adv_at(X, Place)),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.


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
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */
notice_objects_at(Place) :-
        adv_at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).


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
        look.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */
describe(someplace) :- write('You are someplace.'), nl.

