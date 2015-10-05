[![Build Status](https://travis-ci.org/salama/salama-reader.svg?branch=master)](https://travis-ci.org/salama/salama-reader)
[![Gem Version](https://badge.fury.io/rb/salama-reader.svg)](http://badge.fury.io/rb/salama-reader)
[![Test Coverage](https://codeclimate.com/github/salama/salama-reader/badges/coverage.svg)](https://codeclimate.com/github/salama/salama-reader)

## Salama Reader

The parser part of salama is now a standalone gem. It parses bosl using Parslet and no other dependencies.

Also it is very educational, as it is very readable code, and not too much of it.

## Bosl Basic Object System Language

Bosl is just forming after a major insight. I used to nag about C quite randomly before, but now i
found the two main things that make it unsuitable, as a system language, for implementing an Object
system:

- C has inherent non object features. But one could just use structs to get around that.
  One would have to (unlike c++ eg) forbid the usage of large parts of the language
- The calling convention is not object based, ie not upward compatible in an oo system.

Contrary to what i thought before, other features of c are actually needed. Programming
an oo vm without a system language is like programming an os in assembler. All right for some, but
not most.

Specifically a static language is not an obstacle, or even a good thing. One pretends the world
is closed until run-time. Then one needs to have the same compiling capabilities.

Types, or a static type system, is also quite necessary to stay sane. It is "just" a matter of
extending that for oo later. Luckily i have found a system to do that.

Return and argument types for functions are now done!

### Syntax

Syntax (and semantics) of bosl are just forming, but some things are clear:

- statically typed (in the beginning with just two types) meaning all variable declarations,
  functions and arguments shall be typed.
- objects but without data hiding
- probably nil objects
- static blocks (a bit ala crystal)
- call syntax as already discussed, ie message based

Some things we shall leave behind from the ruby approach are a lot of sugar, like missing brackets,
random code everywhere, expressions galore . . .


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

The ast layer now uses the ast gem. That approach is to use a single class to represent all
types of node and use a type symbol (instead of different classes)

This works well, and is much less work.

The following step of compiling use the same kind of visitor approach as before

### Parslet

Parslet is really great in that it:
- does not generate code but instead gives a clean dsl to define a grammar
- uses ruby modules so one can split the grammars up
- has support for binary operators with precedence and binding
- has a separate transform stage to generate an ast layer

Especially the last point is great. Since it is separate it does not clutter up the actual grammar.
And it can generate a layer that has no links to the actual parser anymore, thus saving/automating
a complete transformation process.

### Operators

Parslets operator support is **outstanding** and such it was a breeze to implement most operators
very simply. See the operators.rb for details.
As this started as an attempt to parse ruby, below list of order precedence is close to ruby.
It would not have to be anymore though, and so is subject to change.

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
