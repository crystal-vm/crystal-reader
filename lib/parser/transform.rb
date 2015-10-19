
#include is private in 1.9, who'd have known without travis
Parslet::Context.send :include , AST::Sexp
Parslet::Context.class_eval do
  def type_sym t
    if( t.is_a? AST::Node )
      t = t.children.first
    else
      t = t.to_sym
      t = :Integer if t == :int
    end
    t
  end
end
module Parser
  class Transform < Parslet::Transform

    rule(:string => sequence(:chars)) { s(:string , chars.join) }
    rule(:esc => simple(:esc)) { '\\' +  esc }
    rule(char: simple(:char)) { char }

    rule(:true => simple(:true)) { s(:true) }
    rule(:false => simple(:false)) { s(:false) }
    rule(:nil => simple(:nil)) { s(:nil) }
    rule(:integer => simple(:value)) { s(:int ,value.to_i) }
    rule(:name   => simple(:name))  { s(:name , name.to_sym) }
    # local variables
    rule(:type   => simple(:type), :name   => simple(:name))  { s(:field_def , type_sym(type) , name.to_sym) }
    rule(:type   => simple(:type), :name   => simple(:name) , :value => simple(:value))  {
      s(:field_def , type_sym(type) , name.to_sym , value ) }
    # class field
    rule(:field => simple(:field) , :type   => simple(:type), :name   => simple(:name))  {
      s(:class_field , type_sym(type) , name.to_sym) }
    rule(:field => simple(:field) , :type   => simple(:type), :name   => simple(:name) , :value => simple(:value))  {
      s(:class_field , type_sym(type) , name.to_sym , value ) }

    rule(:l_value => simple(:l_value) , :assign => simple(:assign) , :r_value => simple(:r_value)) {
      s(:assignment , l_value , r_value)
    }
    rule( :left => simple(:left) , :operator => simple(:operator) ,
      :right => simple(:right)) { s(:operator_value , operator.to_sym , left , right )}
    rule(:class_name   => simple(:class_name))  { s(:class_name,class_name.to_s.to_sym) }

    rule(:array_constant => sequence(:array_constant) ) { s(:array , *array_constant) }
    rule(:array_element  => simple(:array_element))    { array_element  }
    rule(:hash_constant => sequence(:hash_constant) ) { s(:hash , *hash_constant) }
    rule(:hash_key => simple(:hash_key) , :hash_value => simple(:hash_value)) {  s(:assoc , hash_key , hash_value) }
    rule(:hash_pair => simple(:hash_pair) ) {  hash_pair }

    rule(:argument  => simple(:argument))    { argument  }
    rule(:argument_list => sequence(:argument_list)) { argument_list }

    #Two rules for calls, simple and qualified. Keeps the rules simpler
    rule( :call_site => simple(:call_site),
          :argument_list    => sequence(:argument_list)) do
           s(:call , call_site, s(:arguments , *argument_list) )
    end
    rule( :receiver => simple(:receiver) , :call_site => simple(:call_site),
          :argument_list    => sequence(:argument_list)) do
           s(:call , call_site, s(:arguments , *argument_list) , s(:receiver , receiver))
    end
    rule( :receiver => simple(:receiver) , :field => simple(:field) ) do
           s(:field_access , s(:receiver , receiver) , s(:field , field) )
    end

    rule(:condition => simple(:condition)  ,
         :conditional     => simple(:conditional),
         :body => {:statements => sequence(:body) , :end => simple(:e) }) do
           s(:while_statement,condition.to_s.to_sym, s(:conditional , conditional), s(:statements , *body))
    end

    rule(:condition  => simple(:condition), :conditional     => simple(:conditional),
         :true_statements  => {:statements => sequence(:true_statements) , :else => simple(:else) },
         :false_statements => {:statements => sequence(:false_statements) , :end => simple(:e) }) do
           s(:if_statement, condition.to_s.to_sym,
                            s(:condition, conditional),
                            s(:true_statements, *true_statements),
                            s(:false_statements , *false_statements))
    end

    rule(:condition  => simple(:condition), :conditional     => simple(:conditional),
         :true_statements  => {:statements => sequence(:true_statements) , :end => simple(:e) }) do
           s(:if_statement, condition.to_s.to_sym, s(:condition, conditional),
                            s(:true_statements, *true_statements), s(:false_statements , nil) )
    end

    rule(:return => simple(:return) , :return_statement => simple(:return_statement))do
       s(:return , return_statement)
     end

    rule(:parameter  => simple(:parameter))    { s(:parameter , *parameter)  }

    # Also two rules for function definitions, unqualified and qualified
    rule(:type => simple(:type) ,
         :function_name   => simple(:function_name),
         :parameter_list => sequence(:parameter_list),
         :statements   => sequence(:statements) , :end => simple(:e)) do
            s(:function, type_sym(type) , function_name,  s(:parameters , *parameter_list ),
            s(:statements , *statements))
          end

    rule(:type => simple(:type) ,
         :receiver=> simple(:receiver),
         :function_name   => simple(:function_name),
         :parameter_list => sequence(:parameter_list),
         :statements   => sequence(:statements) , :end => simple(:e)) do
            s(:function, type_sym(type) , function_name,  s(:parameters , *parameter_list ),
            s(:statements , *statements) , s(:receiver , *receiver))
          end

    rule( :class_name => simple(:class_name) , :derived_name => simple(:derived_name) , :class_statements => sequence(:class_statements) , :end=>"end") do
      s(:class , class_name.to_s.to_sym ,
          s(:derives, derived_name ? derived_name.to_a.first.to_sym : nil) ,
            s(:statements, *class_statements) )
    end

    rule(:statement_list => sequence(:statement_list)) {
      s(:statements , *statement_list)
    }

    #shortcut to get the ast tree for a given string
    # optional second arguement specifies a rule that will be parsed (mainly for testing)
    def self.ast string , rule = :root
      syntax    = Parser.new.send(rule).parse(string)
      tree      = Transform.new.apply(syntax)
      tree
    end
  end
end
