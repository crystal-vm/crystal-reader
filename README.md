[![Build Status](https://travis-ci.org/salama/salama-reader.svg?branch=master)](https://travis-ci.org/salama/salama-reader)
[![Gem Version](https://badge.fury.io/rb/salama-reader.svg)](http://badge.fury.io/rb/salama-reader)
[![Test Coverage](https://codeclimate.com/github/salama/salama-reader/badges/coverage.svg)](https://codeclimate.com/github/salama/salama-reader)

## Salama Reader

The parser part of salama is now a standalone gem. It parses Phisol using Parslet and no other dependencies.

Also it is very educational, as it is very readable code, and not too much of it.

## Phisol Phi System Object Language

Phisol is just forming after realizing the (unfortunate) need for an oo system language.
(I really  didn't want to do yet another language)

 The need comes from these three things:

- a language is needed to translate to. Meaning a software layer is needed, but to understand how
    that layer works, a syntax is needed. Thus is born a language.
- Upward compatible memory and calling conventions are needed
- Multiple return addresses are needed

From these comes the name: A phi node is the opposite of what you may think of as an if. Actually an
if statement is always a branch (the if part) and a rejoining of the two branches (the phi part).

In Phisol a function call is not necessarily a part of linear code. A call may return to several
addresses, making the call more like an if statement.  

### Syntax

Syntax (and semantics) of Phisol are just forming, but some things are clear:

- statically typed (in the beginning with just two types) meaning all variable declarations,
  functions and arguments shall be typed.
- objects but without data hiding
- probably nil objects
- static blocks (a bit ala crystal)
- call syntax as already discussed, ie message based

Some things we shall leave behind from the ruby approach are a lot of sugar, like missing brackets,
random code everywhere, statements galore . . .


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
