require 'parslet'
require "ast"

#include is private in 1.9, who'd have known without travis
Parslet::Context.send :include , AST::Sexp

module Parser
  class Transform < Parslet::Transform

    rule(:string => sequence(:chars)) { s(:string , chars.join) }
    rule(:esc => simple(:esc)) { '\\' +  esc }
    rule(char: simple(:char)) { char }

    rule(:true => simple(:true)) { s(:true) }
    rule(:false => simple(:false)) { s(:false) }
    rule(:nil => simple(:nil)) { s(:nil) }
    rule(:integer => simple(:value)) { s(:int ,value.to_i) }
    rule(:name   => simple(:name))  { s(:name , name.to_s) }
    rule(:type   => simple(:type), :name   => simple(:name))  { s(:field , type.to_sym , name.to_sym) }
    rule(:module_name   => simple(:module_name))  { s(:module,module_name.to_s) }

    rule(:array_constant => sequence(:array_constant) ) { s(:array , array_constant) }
    rule(:array_element  => simple(:array_element))    { array_element  }
    rule(:hash_constant => sequence(:hash_constant) ) { s(:hash , hash_constant) }
    rule(:hash_key => simple(:hash_key) , :hash_value => simple(:hash_value)) {  s(:assoc , hash_key , hash_value) }
    rule(:hash_pair => simple(:hash_pair) ) {  hash_pair }

    rule(:argument  => simple(:argument))    { argument  }
    rule(:argument_list => sequence(:argument_list)) { argument_list }

    #Two rules for calls, simple and qualified. Keeps the rules simpler
    rule( :call_site => simple(:call_site),
          :argument_list    => sequence(:argument_list)) do
           s(:call , call_site, argument_list )
    end
    rule( :receiver => simple(:receiver) , :call_site => simple(:call_site),
          :argument_list    => sequence(:argument_list)) do
           s(:call , call_site, argument_list , receiver)
    end

    rule(:if => simple(:if), :conditional     => simple(:conditional),
         :if_true  => {:expressions => sequence(:if_true) , :else => simple(:else) },
         :if_false => {:expressions => sequence(:if_false) , :end => simple(:e) }) do
           s(:if , conditional, if_true, if_false)
    end

    rule(:if => simple(:if), :conditional     => simple(:conditional),
         :if_true  => {:expressions => sequence(:if_true) , :end => simple(:e) }) do
           s(:if , conditional, if_true, nil)
    end

    rule(:while     => simple(:while),
         :while_cond => simple(:while_cond)  ,
         :body => {:expressions => sequence(:body) , :end => simple(:e) }) do
           s(:while , while_cond, body)
         end

    rule(:return => simple(:return) , :return_expression => simple(:return_expression))do
       s(:return , return_expression)
     end

    rule(:parameter  => simple(:parameter))    { parameter  }
    rule(:parameter_list => sequence(:parameter_list)) { parameter_list }

    # Also two rules for function definitions, unqualified and qualified
    rule(:function_name   => simple(:function_name),
         :parameter_list => sequence(:parameter_list),
         :expressions   => sequence(:expressions) , :end => simple(:e)) do
            s(:function, function_name, parameter_list, expressions)
          end

    rule(:function_name   => simple(:function_name),
         :expressions   => sequence(:expressions) , :end => simple(:e)) do
            s(:function , function_name, [], expressions)
          end

    rule(:receiver=> simple(:receiver),
         :function_name   => simple(:function_name),
         :parameter_list => sequence(:parameter_list),
         :expressions   => sequence(:expressions) , :end => simple(:e)) do
            s(:function, function_name, parameter_list, expressions , receiver)
          end

    rule(l: simple(:l), o: simple(:o) , r: simple(:r)) do
      op = o.to_s.strip
      if op == "="
        s(:assign , l ,r)
      else
        s(:operator, op , l ,r)
      end
    end

    #modules and classes are understandibly quite similar   Class < Module
    rule( :module_name => simple(:module_name) , :module_expressions => sequence(:module_expressions) , :end=>"end") do
      s(:module , module_name , module_expressions)
    end
    rule( :module_name => simple(:module_name) , :derived_name => simple(:derived_name) , :class_expressions => sequence(:class_expressions) , :end=>"end") do
      s(:class , module_name , derived_name ? derived_name : nil , class_expressions)
    end

    rule(:expression_list => sequence(:expression_list)) {
      s(:list , expression_list)
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
