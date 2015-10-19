module Parser
  module Keywords
    include Parslet

    rule(:keyword_begin)  {  str('begin').as(:begin) >> space?}
    rule(:keyword_class)  {  str('class') >> space? }
    rule(:keyword_else)   {  str('else').as(:else) >> space? }
    rule(:keyword_end)    {  str('end').as(:end) >> space? }
    rule(:keyword_false)  {  str('false').as(:false) }
    rule(:keyword_field)  {  str('field').as(:field) >> space? }
    rule(:keyword_return) {  str('return').as(:return) >> space?}
    rule(:keyword_true)   {  str('true').as(:true) }
    rule(:keyword_nil)    {  str('nil').as(:nil) }

    # this rule is just to make sure identifiers can't be keywords. Kind of duplication here, but we need the
    # space in above rules, so just make sure to add any here too.
    rule(:keyword){ str('if_')    | str('else') | str('end') | str('while_') |
                    str('false') | str('true')| str('nil') | str("class") |
                    str('return')| str('int')|  str('field')}
  end
end
