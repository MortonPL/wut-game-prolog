/*
╔════════════════════════════════════╗
║ Filename: serialize.pl             ║
║ Title: Serialization predicates    ║
╚════════════════════════════════════╝
*/

:- [header].

:-
        has_included(serialize);
        % All serializable game data should be asserted here.
        assert(serializable(adv_i_am_at/1)),     assert(serializable(adv_in_inventory/3)),
        assert(serializable(adv_player_name/1)), assert(serializable(sys_last_savename/1)).

% pragma once
:- has_included(serialize);assert(has_included(serialize)).

/**HELPER
 * serializables(--List:list)
 * 
 * Loads all serializable predicates into List.
 * Always succeedes.
 */
serializables(List) :-
        bagof(S, serializable(S), List)
        ;
        true.


/**COMMAND
 * save(+File:atom|string)
 * 
 * Saves all serializable predicates & terms in saves/File.sav.
 */
save(File) :-
        atomic_list_concat(['saves/', File, '.sav'], '', Path),
        tell(Path),
        serializables(Serializables),
        foreach(member(S, Serializables),
        (
            listing(S)
        )),
        told.

/**COMMAND
 * save()
 * 
 * Quicksaves in the last used file. If haven't saved yet, prompts user for name.
 */
save :-
        (sys_last_savename(Name) ->
                true
                ;
                get_input('Please enter a save name (wrapped in '''') or say cancel:', Name, sys_last_savename(Name), cancel)
        ),
        save(Name).


/**COMMAND
 * load(+File:atom|string)
 * 
 * Loads all serializable predicates & terms from saves/File.sav.
 */
load(Name) :-
        atomic_list_concat(['saves/', Name, '.sav'], '', Path),
        reset_game,
        open(Path, read, Fd),
        serializables(Serializables),
        % For each entry in the save file
        repeat,
                read_term(Fd, Term, []),
                (Term == end_of_file ->
                        !
                        ; 
                        % match compound term with functor name/arity
                        (foreach((member(FCmpd,Serializables),
                                term_to_atom(FCmpd, FAtom),
                                sub_atom(FAtom, 0, _, 2, FName),
                                sub_atom(FAtom, _, 1, 0, FArity),
                                number_codes(FArityInt, [FArity]),
                                functor(Term, FName, FArityInt)),
                        (
                                assert(Term)
                        )),
                        fail
                        )
                ),
        close(Fd), !,
        game_start.

/**COMMAND
 * load()
 * 
 * Quickloads from the last used file. If haven't loaded yet, prompts user for name.
 */
load :-
        (sys_last_savename(Name) ->
                true
                ;
                get_input('Please enter a save name (wrapped in ''''), or say cancel:', Name, sys_last_savename(Name), cancel)
        ),
        load(Name).


/**SYSTEM
 * reset_game()
 * 
 * Abolishes all serializable predicates from the database and reloads them.
 * Always succeedes.
 */
reset_game :-
        serializables(Serializables),
        foreach(member(S, Serializables), 
        (
                abolish(S)
        )),
        retract(has_included(serialize)),
        [serialize].

