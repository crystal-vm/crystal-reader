module Parser
  # Basic types are numbers and strings
  module BasicTypes
    include Parslet

    # unicode generalized categories , according to regex ruby page
    rule(:lower)  { match "[[:lower:]]" }    # Lowercase alphabetical character
    rule(:upper)  { match "[[:upper:]]" }    # Uppercase alphabetical
    rule(:alnum)  { match "[[:alnum:]]" }    # Alphabetic and numeric character
    rule(:alpha)  { match "[[:alpha:]]" }    # Alphabetic character
    rule(:blank)  { match "[[:blank:]]" }    # Space or tab
    rule(:space)  { match("[[:space:]]").repeat }    # Whitespace character ([:blank:], newline, carriage return, etc.)
    rule(:digit)  { match "[[:digit:]]" }    # Digit
    rule(:graph)  { match "[[:graph:]]" }    # Non-blank character (excludes spaces, control characters, and similar)
    rule(:print)  { match "[[:print:]]" }    # Like [:graph:], but includes the space character
    rule(:xdigit) { match "[[:xdigit:]]"}    # Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F)


    # rule of thumb is that anything eats space behind it, but only space, no newlines
    rule(:space?) { space.maybe }
    rule(:linebreak){ str("\n") >> space? >> linebreak.repeat }

    rule(:quote)      { str('"') }
    rule(:nonquote)   { str('"').absent? >> any }

    rule(:comment){ match('#') >> (linebreak.absent? >> any).repeat >> linebreak }
    rule(:newline) { (linebreak | comment) >> space? }
    rule(:eol) { newline  | any.absent? }

    rule(:double_quote){ str('"') }
    rule(:minus) { str('-') }
    rule(:plus) { str('+') }

    rule(:sign) { plus | minus }
    rule(:dot) {  str('.') }
    rule(:digit) { match('[0-9]') }
    rule(:exponent) { (str('e')| str('E')) }

    rule(:type) { (str("int") | str("ref")).as(:type) >> space }
    # identifier must start with lower case
    # TODO rule forbit names like if_true, because it starts with a keyword. a little looser please!
    rule(:name)   { (keyword|type).absent? >> (match['a-z_'] >> match['a-zA-Z0-9_'].repeat).as(:name)  >> space? }
    # fields have type
    rule(:field) { type >> name >> (assign >> r_value.as(:value) ).maybe}
    rule(:class_field) { keyword_field >> field }
    # and class/module names must start with capital
    rule(:class_name) { keyword.absent? >> (match['A-Z'] >> match['a-zA-Z0-9_'].repeat).as(:class_name)  >> space? }

    rule(:escape)     { str('\\') >> any.as(:esc) }
    rule(:string)     { quote >> (
        escape |
        nonquote.as(:char)
      ).repeat(1).as(:string) >> quote }

    rule(:integer)    { sign.maybe >> digit.repeat(1).as(:integer) >> space? }

    rule(:float) { integer >>  dot >> integer >>
                            (exponent >> sign.maybe >> digit.repeat(1,3)).maybe >> space?}
    rule(:basic_type){ integer | name | string | float | field | class_name |
                       keyword_true | keyword_false | keyword_nil }
  end
end
