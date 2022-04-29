/*
╔════════════════════════════════════╗
║ Filename: command.pl               ║
║ Title: Command interface extras    ║
╚════════════════════════════════════╝
*/

:- [header].

:- 
        has_included(command);
        % All player commands should be asserted here.
        assert(command(helpme)),    assert(command(start)), assert(command(quit)),      assert(command(north)),
        assert(command(n)),         assert(command(south)), assert(command(s)),         assert(command(west)),
        assert(command(w)),         assert(command(east)),  assert(command(e)),         assert(command(take)),
        assert(command(drop)),      assert(command(look)),  assert(command(inventory)), assert(command(i)),
        assert(command(buy)),       assert(command(sell)).

% pragma once
:- has_included(command);assert(has_included(command)).

/**SYSTEM
 * confirm(+Prompt:atom|string|int|float)
 * 
 * Repeatedly Prompts the user with a question until they respond with yes or no.
 * True for yes, false for no.
 */
confirm(Question) :-
        format('~w (yes/no)~n', [Question]),
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
