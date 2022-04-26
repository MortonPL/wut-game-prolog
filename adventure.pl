/* <The name of this game>, by <your name goes here>. */
/*
╔════════════════════════════════════╗
║ Filename: adventure.pl             ║
║ Title: Boot file                   ║
║ Reload: Forbidden                  ║
╚════════════════════════════════════╝
*/

% Consult all needed files.
:- [command, helpme, serialize, adventure_core].

% Forward declare predicates.
:- dynamic sys_first_session/0.

% Assert system data.
sys_first_session :- true.

/**COMMAND
 * start()
 * 
 * Resets the game state and begins the adventure.
 * If this isn't the first session (i.e. user loaded a save)
 * ask user for confirmation.
 * Fails if the user doesn't confirm his choice (only in not first session).
 */
start() :- 
        (sys_first_session ->
                true
                ;
                confirm('Are you sure you want to restart?')
        ),
        reset_game,
        consult(adventure_new),
        get_input('What is your name? (Wrapped in '''')', Name, adv_player_name(Name)),
        game_start.

/**COMMAND
 * quit()
 * 
 * Exits the game and Prolog shell.
 */
quit() :-
        halt.


/**COMMAND
 * menu()
 * 
 * Displays menu commands (unaffecting the game) to the player.
 */
menu() :-
        writeln('Hello! What do you want to do?'),
        writeln('    start. - Start a new game.'),
        writeln('    save.  - Make a new save file.'),
        writeln('    load.  - Load a saved file.'),
        writeln('    quit.  - Exit the game.').

:- menu.
