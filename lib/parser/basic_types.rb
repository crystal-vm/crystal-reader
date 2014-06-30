module Parser
  # Basic types are numbers and strings
  module BasicTypes
    include Parslet
    # space really is just space. ruby is newline sensitive, so there is more whitespace footwork
    # rule of thumb is that anything eats space behind it, but only space, no newlines
    rule(:space)  { (str('\t') | str(' ')).repeat(1) }
    rule(:space?) { space.maybe }
    rule(:linebreak){ str("\n") >> space? >> linebreak.repeat }
    
    rule(:quote)      { str('"') }
    rule(:nonquote)   { str('"').absent? >> any }

    rule(:comment){ match('#') >> (linebreak.absent? >> any).repeat >> linebreak }
    rule(:newline) { linebreak | comment }
    rule(:eol) { newline  | any.absent? }
    
    rule(:double_quote){ str('"') }
    rule(:minus) { str('-') }
    rule(:plus) { str('+') }

    rule(:sign) { plus | minus }
    rule(:dot) {  str('.') }
    rule(:digit) { match('[0-9]') }
    rule(:exponent) { (str('e')| str('E')) }
     
    # identifier must start with lower case
    # TODO rule forbit names like if_true, because it starts with a keyword. a little looser please!
    rule(:name)   { keyword.absent? >> (match['a-z_'] >> match['a-zA-Z0-9_'].repeat).as(:name)  >> space? }
    # instance variables must have the @
    rule(:instance_variable) { (str('@') >> name).as(:instance_variable) }
    # and class/module names must start with capital 
    # (admittatly the rule matches constants too, but one step at a time)
    rule(:module_name) { keyword.absent? >> (match['A-Z'] >> match['a-zA-Z0-9_'].repeat).as(:module_name)  >> space? }
    
    rule(:escape)     { str('\\') >> any.as(:esc) }
    rule(:string)     { quote >> (
        escape | 
        nonquote.as(:char)
      ).repeat(1).as(:string) >> quote }
    
    rule(:integer)    { sign.maybe >> digit.repeat(1).as(:integer) >> space? }
    
    rule(:float) { integer >>  dot >> integer >> 
                            (exponent >> sign.maybe >> digit.repeat(1,3)).maybe >> space?}
    rule(:basic_type){ integer | name | string | float | instance_variable | module_name | 
                       keyword_true | keyword_false | keyword_nil }
  end
end