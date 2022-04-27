/*
╔══════════════════════════════╗
║ Filename: helpme.pl          ║
║ Title: Help predicates       ║
║ Reload: Safe                 ║
╚══════════════════════════════╝
*/


/*COMMAND
 * helpme()
 *
 * Displays possible commands to the player.
 * Always succeedes.
 */
helpme :-
        writeln('Enter commands using standard Prolog syntax.'),
        writeln('Available commands are:'),
        writeln('helpme.                -- to see this message again.'),
        writeln('helpme(Topic).         -- to get detailed help on a command or topic.'),
        writeln('start.                 -- to start the game.'),
        writeln('quit.                  -- to end the game and exit Prolog shell.'),
        writeln('n.  s.  e.  w.         -- to go in that direction.'),
        writeln('take(Object).          -- to pick up an Object.'),
        writeln('drop(Object).          -- to put down an Object.'),
        writeln('look.                  -- to look around you again.').

/*COMMAND
 * helpme(+Command:atom)
 *
 * Describes given Command to the player if it is a valid command.
 * Otherwise, tell the player the command is invalid.
 */
helpme(Command) :-
        (command(Command) ->
                writeln(Command)
                ;
                write('Invalid command: '),
                write(Command), nl
        ).
