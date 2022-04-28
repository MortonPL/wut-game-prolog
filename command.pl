/*
╔════════════════════════════════════╗
║ Filename: command.pl               ║
║ Title: Command interface extras    ║
║ Reload: Safe                       ║
╚════════════════════════════════════╝
*/

% All player commands should be asserted here.
command(helpme).    command(start). command(quit).  command(n).
command(s).         command(e).     command(w).     command(take).
command(drop).      command(look).


/**SYSTEM
 * confirm(+Prompt:atom|string|int|float)
 * 
 * Repeatedly Prompts the user with a question until they respond with yes or no.
 * True for yes, false for no.
 */
confirm(Question) :-
        atomics_to_string([Question, '(yes/no)'], Q),
        writeln(Q),
        repeat,
                read(A),
                (member(A, [yes, no]) ->
                !
                ;
                fail
                ),
        A == yes.


/**SYSTEM
 * get_input(+Prompt:any, --Var:var, :Term:cmpd)
 * 
 * Prompts the user for some input to store in Var and use in Predicate.
 * Always true.
 */
get_input(Prompt, Var, Predicate) :-
        writeln(Prompt),
        read(Var),
        assert(Predicate).

/**SYSTEM
 * get_input(+Prompt:any, --Var:var, :Term:cmpd, +Cancel:atom)
 * 
 * Prompts the user for some input to store in Var and use in Predicate.
 * User can cancel the prompt by typing Cancel.
 * True if user doesn't cancel, false otherwise.
 */
get_input(Prompt, Var, Predicate, Cancel) :-
        writeln(Prompt),
        read(Var),
        \+ (Var == Cancel),
        assert(Predicate).

/**SYSTEM
 * get_description(+Command:atom) 
 * 
 * Writes an extended description for the Command. Always true.
 */
get_description(start) :-
        writeln('start. - Start a new game. All progress will be lost!').

get_description(quit) :-
        writeln('quit. - Quit the game and exit Prolog shell. All progress will be lost!').

get_description(n) :-
        writeln('n. - Move North of the current location if possible.').

get_description(s) :-
        writeln('s. - Move South of the current location if possible.').

get_description(w) :-
        writeln('w. - Move West of the current location if possible.').

get_description(e) :-
        writeln('e. - Move East of the current location if possible.').

get_description(take) :-
        writeln('take(Object). - Pick up an Object in the current location and place it in your inventory.').

get_description(drop) :-
        writeln('drop(Object). - Remove an Object from your inventory and leave it in the current location.').

get_description(look) :-
        writeln('look. - Examine the current location again.').

/**SYSTEM
 * get_description(+Object:atom) 
 * 
 * Writes an extended description for the Object.
 */

% todo
