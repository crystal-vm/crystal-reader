## Salama Reader*

The parser part of salama is now a standalone gem. It parses ruby using Parslet and no other dependencies.

This is interesting if you want to generate executable code, like salama, but also for other things, like code analysis.

Also it is very educational, as it is very readable code, and not too much of it.

*
It looks into it's salama ball and all it sees is red. A red salama . . . ruby, yes.

### Parser

The main parser per se is in parser/salama , but it just pulls in all the parts.

All the other files are ruby modules representing aspects of the parser.
Most names are quite self explanatory, but here is a list:

- basic_type defines just that. Strings, symbols, integers, floats , also comments and space
- call_site is a function call. May be qualified, but currently must still have braches
- compound types are hash and array definitions. Hashes still need curlies
- control is if statement which still must have an else
- expression is a helper for all code allowed in a function
- function definition must have braces too
- keywords is just a list of them
- operator expression are binary operators (see also below). There's a surprising amount
- return statement are straightforward
- while still needs a do, though i think in ruby a newline is sufficient

**Transform** defines how the rules map to Ast objects.

### Ast

The Abtract Syntax Tree (ast) layer puts the parsed code into objects, so they are nice and easy to work with.

The Classes don't really define any functionality, that is done in Salama, or can be done in any code using this. Salama just adds a compile function to each class, but a visitor pattern would do just as well.

The functionality that is in there is mainly to do with testing. Equality is defined, but also **inspect** in such a way that it's output (which you get from a failing test) can be pasted straight into the test case as the expected result.


### Parslet

Parslet is really great in that it:
- does not generate code but instead gives a clean dsl to define a grammar
- uses ruby modules so one can split the grammars up
- has support for binary operators with precedence and binding
- has a separate transform stage to generate an ast layer

Especially the last point is great. Since it is separate it does not clutter up the actual grammar.
And it can generate a layer that has no links to the actual parser anymore, thus saving/automating
a complete transformation process.

### Todo

A random list of things left for the future

- extract commonality of function call/definition,array, hash and multi assignment comma lists
- break and next
- blocks
- more loops, i'm not even sure what ruby supports
- ifs without else, also elsif
- negative tests

### Operators

Parslets operator support is **outstanding** and such it was a breeze to implement most of rubies operators very simply. See the operators.rb for details. Below is a list from the web of how it should be.


Operator list from http://stackoverflow.com/questions/21060234/ruby-operator-precedence-table

N A M  Operator(s)            Description
- - -  -----------            -----------
1 R Y  ! ~ +                  boolean NOT, bitwise complement, unary plus
                              (unary plus may be redefined from Ruby 1.9 with +@)

2 R Y  **                     exponentiation
1 R Y  -                      unary minus (redefine with -@)

2 L Y  * / %                  multiplication, division, modulo (remainder)
2 L Y  + -                    addition (or concatenation), subtraction

2 L Y  << >>                  bitwise shift-left (or append), bitwise shift-right
2 L Y  &                      bitwise AND

2 L Y  | ^                    bitwise OR, bitwise XOR (exclusive OR)
2 L Y  < <= >= >              ordering

2 N Y  == === != =~ !~ <=>    equality, pattern matching, comparison
                              (!= and !~ may not be redefined prior to Ruby 1.9)

2 L N  &&                     boolean AND
2 L N  ||                     boolean OR

2 N N  .. ...                 range creation (inclusive and exclusive)
                              and boolean flip-flops

3 R N  ? :                    ternary if-then-else (conditional)
2 L N  rescue                 exception-handling modifier

2 R N  =                      assignment
2 R N  **= *= /= %= += -=     assignment
2 R N  <<= >>=                assignment
2 R N  &&= &= ||= |= ^=       assignment

1 N N  defined?               test variable definition and type
1 R N  not                    boolean NOT (low precedence)
2 L N  and or                 boolean AND, boolean OR (low precedence)
2 N N  if unless while until  conditional and loop modifiers
