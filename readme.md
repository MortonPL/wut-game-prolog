# Project name

Project description.

## Authors
* Bartłomiej Moroz
* Jakub Motyka
* Dawid Sygocki

# Documentation & style guide

## Predicate documentation
Predicate is referenced in `predicate/arity` form, i.e. write/1.
Predicate definition is pseudo SWI Prolog style.
```
/**usage
 * predicate_name(arguments)
 * description
 */
```

### Usage
* `COMMAND` Predicates that can be called by the player.
* `SYSTEM` Predicates that shouldn't be called by the player and are important.
* `HELPER` Predicates that are smaller helpers.

### Term types
* `any` Anything
* `atom` Atom
* `string` String
* `int` Integer
* `float` Floating point number
* `var` Variable
* `cmpd` Compound term aka predicate
* `list` List

### Argument types
* `++` Ground (fully known) term at call-time
* `+`  Instantiated
* `:`  Instantiated meta-argument (i.e. predicate)
* `@`  Instantiated, constant
* `?`  No requirements
* `-`  Output, variable or term
* `--` Output, variable unbound at call-time

Example (taken from SWI Prolog's [between/3](https://www.swi-prolog.org/pldoc/doc_for?object=between/3)):
```
/**
 * between(+Low:int, +High:int, ?Value)
 *
 * Low and High are integers, High >=Low. If Value is an integer, Low =<Value =<High.
 * When Value is a variable it is successively bound to all integers between Low and High.
 * If High is inf or infinite117 between/3 is true iff Value >=Low, a feature that is particularly 
 * interesting for generating integers from a certain value.
 */
```

## Style guide

### Project structure
All source code files should begin with a following header :
```
/*
╔════════════════════════════════════╗
║ Filename:                          ║
║ Title:                             ║
║ Reload: Safe | Unsafe | Forbidden  ║
╚════════════════════════════════════╝
*/
```
Safe reload describes the effect of reconsulting the file - Safe can be reloaded freely, Unsafe only when aware of the consequences, Forbidden should never be reloaded.

### Indentation
Indentation with 8 spaces.

Predicate heads *should not* be indented. Bodies *should be* indented.

### Spacing
Different predicates should be separated by **two** newlines.

"Overloaded" predicates (with differing argument count or different effects) should be separated by **one** newline.

### If-then-else
If-then-else constructions should be formatted in the following way:
```
(condition ->
    do_if_true,
    do_if_true_more
    ;
    do_if_false,
    do_if_false_more
).
```

### Failure-driven loops
Failure-driven loop bodies should be indented after `repeat` and stop being indented the moment the loop ends.
