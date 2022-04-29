/* <The name of this game>, by <your name goes here>. */
/*
╔════════════════════════════════════╗
║ Filename: adventure.pl             ║
║ Title: Boot file                   ║
╚════════════════════════════════════╝
*/

:- dynamic has_included/1.

% Consult all needed files.
:- [header, command, helpme, serialize, adventure_core, map].

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
        ),!,
        reset_game,!,
        [adventure_new],
        get_input('What is your name? (Wrapped in '''')', Name, adv_player_name(Name)),
        intro.


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
        writeln('    start. - Start a new game.'),
        writeln('    save.  - Make a new save file.'),
        writeln('    load.  - Load a saved file.'),
        writeln('    quit.  - Exit the game.').

/**SYSTEM
 * welcome()
 * 
 * Displays the main menu.
 */
welcome() :-
        writeln('╔════════════════════════════════════╗'),
        writeln('║       ''AHOY'' IS FIVE DOLLARS       ║'),
        writeln('║   A text adventure trading game.   ║'),
        writeln('╚════════════════════════════════════╝'),
        nl,
        writeln('              |    |    |  '),
        writeln('             )_)  )_)  )_)'),
        writeln('            )___))___))___)'),
        writeln('           )____)____)_____)'),
        writeln('         _____|____|____|________'),
        writeln('~~~~~~~~~\\   lvl 1 crook   \\   /~~~~~~~~~'),
        writeln('  ^^~^^ ^^^~~~~^^^^^~~^^^^^^^    ^^~~^~'),
        writeln('    ^^^  ~~   ^^^^     ^^~    ~~~~'),
        writeln(' ~~      ~~^^      ^~^     ~~         ^^~~^'),
        nl,
        writeln('        by B.Moroz,J.Motyka,D.Sygocki, 2022'),
        nl,
        menu().


/**SYSTEM
 * intro()
 * 
 * Displays the synopsis of the game plot.
 */
intro() :-
        writeln('[~~~~~~~~~~~~~~~~~~~~~~ YOUR STORY ~~~~~~~~~~~~~~~~~~~~~~]'),
        writeln('There are rumours of a great Aztec treasure hidden'),
        writeln('somewhere in the wilds of this archipelago, which'),
        writeln('can only be found with an equally ancient map, torn'),
        writeln('to pieces by restless time.'),
        nl,
        writeln('In a pursuit for the riches you too took everything'),
        writeln('you had and bought a small schooner to sail the sea.'),
        nl,
        adv_player_name(Name),
        format('~w, embark on your journey, make the most of~n', [Name]),
        writeln('your trading skills and good fortune to collect all'),
        writeln('TWO MAP PIECES and become rich beyond reason.'),
        nl,
        confirm('Are you ready?'),
        game_start.


:- welcome.
