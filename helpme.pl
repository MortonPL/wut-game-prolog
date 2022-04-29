/*
╔══════════════════════════════╗
║ Filename: helpme.pl          ║
║ Title: Help predicates       ║
╚══════════════════════════════╝
*/

:- [header].

% pragma once
:- has_included(helpme);assert(has_included(helpme)).

/*COMMAND
 * helpme()
 *
 * Displays possible commands to the player.
 * Always succeedes.
 */
helpme :-
        writeln('Enter commands using standard Prolog syntax.'),
        writeln('Available commands are:'),
        writeln('META-GAME OPTIONS:'),
        writeln('  helpme.                              -- to see this message again.'),
        writeln('  helpme(Command).                     -- to get detailed help on a Command.'),
        writeln('  start.                               -- to start a new game.'),
        writeln('  menu.                                -- to see the main menu options.'),
        writeln('  quit.                                -- to end the game and exit Prolog shell.'),
        writeln('IN-GAME OPTIONS:'),
        writeln('  n. / north.                          -- to go in that direction.'),
        writeln('  s. / south.'),
        writeln('  w. / west.'),
        writeln('  e. / east.'),
        writeln('  i. / inventory.                      -- to check your items'),
        writeln('  look.                                -- to look around you.'),
        writeln('  take(Item) / take(Item, Amount).     -- to pick up all or Amount of Item.'),
        writeln('  drop(Item) / drop(Item, Amount).     -- to put down all or Amount of Item.'),
        writeln('  inspect(Item).                       -- to take a better look at an Item.'),
        writeln('  buy(Trader, Item, Amount).           -- to buy an Amount of Item from a Trader.'),
        writeln('  sell(Trader, Item, Amount).          -- to sell an Amount of Item from a Trader.'),
        writeln('  ask(Trader).                         -- to ask Trader about his topics.'),
        writeln('  ask(Trader, Topic).                  -- to ask Trader about a Topic.').

/*COMMAND
 * helpme(+Command:atom)
 *
 * Describes given Command to the player if it is a valid command.
 * Otherwise, tell the player the command is invalid.
 */
helpme(Command) :-
        (command(Command) ->
                get_description(Command)
                ;
                write('Invalid command: '),
                write(Command), nl
        ).


/**HELPER
 * get_description(+Command:atom) 
 * 
 * Writes an extended description for the Command. Always true.
 */
get_description(start) :-
        writeln('start. - Start a new game. All progress will be lost!').

get_description(quit) :-
        writeln('quit. - Quit the game and exit Prolog shell. All progress will be lost!').

get_description(north) :-
        writeln('n. / north. - Move north of the current location if possible.').

get_description(n) :-
        get_description(north).

get_description(south) :-
        writeln('s. / south. - Move south of the current location if possible.').

get_description(s) :-
        get_description(south).

get_description(west) :-
        writeln('w. / west. - Move west of the current location if possible.').

get_description(w) :-
        get_description(west).

get_description(east) :-
        writeln('e. / east. - Move east of the current location if possible.').

get_description(e) :-
        get_description(east).

get_description(take) :-
        writeln('take(Object). - Pick up an Object in the current location and place it in your inventory.').

get_description(drop) :-
        writeln('drop(Object). - Remove an Object from your inventory and leave it in the current location.').

get_description(look) :-
        writeln('look. - Examine the current and surrounding locations.').

get_description(inventory) :-
        writeln('i / inventory. - Get a list of all carried items and their amounts.').

get_description(i) :-
        get_description(inventory).

get_description(buy) :-
        get_description('buy(Trader, Item, Amount). - Buy an Amount of Item with a Trader for money.').

get_description(sell) :-
        get_description('sell(Trader, Item, Amount). - Sell an Amount of Item with a Trader for money.').

get_description(ask) :-
        get_description('ask(Trader) / ask(Trader, Item). - Gain any sort of useful information from a Trader.').
