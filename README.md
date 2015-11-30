[![Build Status](https://travis-ci.org/salama/soml-parser.svg?branch=master)](https://travis-ci.org/salama/soml-parser)
[![Gem Version](https://badge.fury.io/rb/soml-parser.svg)](http://badge.fury.io/rb/soml-parser)
[![Test Coverage](https://codeclimate.com/github/salama/soml-parser/badges/coverage.svg)](https://codeclimate.com/github/salama/soml-parser)

## Soml Parser

The parser part of soml is a standalone gem to allow independent development.
It parses Soml using Parslet and no other dependencies.

Also it is very educational, as it is very readable code, and not too much of it.

## Soml: Salama Object Machine Language

Soml is Still forming after realizing the need for an oo system language.

 The need comes from these three things:

- a language is needed to translate to. Meaning a software layer is needed, but to understand how
    that layer works, a syntax is needed. Thus is born a language.
- Upward compatible memory and calling conventions are needed
- Multiple return addresses are needed

In Soml a function call is not necessarily a part of linear code. A call may return to several
addresses, making the call more like an if statement.  

### Syntax

Syntax and semantics of Soml are described on the [salama site](http://salama-vm.org/soml/soml.html)

- statically typed so all variable declarations, functions and arguments are typed.
- objects but without data hiding
- static blocks (a bit ala crystal)
- call syntax as already discussed, ie message based
- no semicolns and stuff, but not ruby either

### Parser

The main parser per se is in parser/salama , but it just pulls in all the parts.

All the other files are ruby modules representing aspects of the parser.
Most names are quite self explanatory, but here is a list:

- basic_type defines just that. Strings, symbols, integers, floats , also comments and space
- call_site is a function call. May be qualified, but currently must still have braches
- compound types are hash and array definitions. Hashes still need curlies
- control is if statement which still must have an else
- statement is a helper for all code allowed in a function
- function definition must have braces too
- keywords is just a list of them
- operator statement are binary operators (see also below). There's a surprising amount
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
