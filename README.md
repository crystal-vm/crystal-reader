## Crystal Reader*

The parser part of crystal is now a standalone gem. It parses ruby using Parslet and no other dependencies.

This is interesing if you want to generate executable code, like crystal, but also for other things, like code analysis.

Also it is very educational, as it is very readable code, and not too much of it.

*
It looks into it's crystal ball and all it sees is red. A red crystal . . . ruby code, yes.

### Parslet

Parslet is really great in that it:
- does not generate code but instean gives a clean dsl to define a grammar
- uses ruby modules so one can split the grammars up
- has support for binary operators with presedence and binding
- has a seperate tranform stage to generate an ast layer

Especially the last point is great. Since it is seperate it does not clutter up the actual grammar.
And it can generate a layer that has no links to the actual parser anymore, thus saving/automating
a complete tranformation process. 

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