require 'parslet'
require 'ast/expression'

module Parser
  class Transform < output::Transform
    rule(:string => sequence(:chars)) { Ast::StringExpression.new chars.join }
    rule(:esc => simple(:esc)) { '\\' +  esc }
    rule(char: simple(:char)) { char }

    rule(:true => simple(:true)) { Ast::TrueExpression.new() }
    rule(:false => simple(:false)) { Ast::FalseExpression.new() }
    rule(:nil => simple(:nil)) { Ast::NilExpression.new() }
    rule(:integer => simple(:value)) { Ast::IntegerExpression.new(value.to_i) }
    rule(:name   => simple(:name))  { Ast::NameExpression.new(name.to_s) }
    rule(:instance_variable   => simple(:instance_variable))  { Ast::VariableExpression.new(instance_variable.name) }
    rule(:module_name   => simple(:module_name))  { Ast::ModuleName.new(module_name.to_s) }

    rule(:array_constant => sequence(:array_constant) ) { Ast::ArrayExpression.new(array_constant) } 
    rule(:array_element  => simple(:array_element))    { array_element  }
    rule(:hash_constant => sequence(:hash_constant) ) { Ast::HashExpression.new(hash_constant) } 
    rule(:hash_key => simple(:hash_key) , :hash_value => simple(:hash_value)) {  Ast::AssociationExpression.new(hash_key,hash_value) }
    rule(:hash_pair => simple(:hash_pair) ) {  hash_pair }

    rule(:argument  => simple(:argument))    { argument  }
    rule(:argument_list => sequence(:argument_list)) { argument_list }

    #Two rules for calls, simple and qualified. Keeps the rules simpler
    rule( :call_site => simple(:call_site), 
          :argument_list    => sequence(:argument_list)) do
           Ast::CallSiteExpression.new(call_site.name, argument_list )
    end
    rule( :receiver => simple(:receiver) , :call_site => simple(:call_site), 
          :argument_list    => sequence(:argument_list)) do
           Ast::CallSiteExpression.new(call_site.name, argument_list , receiver) 
    end

    rule(:if => simple(:if), :conditional     => simple(:conditional),
         :if_true  => {:expressions => sequence(:if_true) , :else => simple(:else) },
         :if_false => {:expressions => sequence(:if_false) , :end => simple(:e) }) do
           Ast::IfExpression.new(conditional, if_true, if_false) 
         end

    rule(:while     => simple(:while),
         :while_cond => simple(:while_cond) , :do => simple(:do) , 
         :body => {:expressions => sequence(:body) , :end => simple(:e) }) do
           Ast::WhileExpression.new(while_cond, body) 
         end

    rule(:return => simple(:return) , :return_expression => simple(:return_expression))do
       Ast::ReturnExpression.new(return_expression) 
     end

    rule(:parameter  => simple(:parameter))    { parameter  }
    rule(:parameter_list => sequence(:parameter_list)) { parameter_list }

    # Also two rules for function definitions, unqualified and qualified
    rule(:function_name   => simple(:function_name),
         :parameter_list => sequence(:parameter_list),
         :expressions   => sequence(:expressions) , :end => simple(:e)) do
            Ast::FunctionExpression.new(function_name.name, parameter_list, expressions)
          end

    rule(:function_name   => simple(:function_name),
         :expressions   => sequence(:expressions) , :end => simple(:e)) do
            Ast::FunctionExpression.new(function_name.name, [], expressions)
          end

    rule(:receiver=> simple(:receiver),
         :function_name   => simple(:function_name),
         :parameter_list => sequence(:parameter_list),
         :expressions   => sequence(:expressions) , :end => simple(:e)) do
            Ast::FunctionExpression.new(function_name.name, parameter_list, expressions , receiver)
          end

    rule(l: simple(:l), o: simple(:o) , r: simple(:r)) do 
      op = o.to_s.strip
      if op == "="
        Ast::AssignmentExpression.new( l ,r)
      else
        Ast::OperatorExpression.new( op , l ,r)
      end
    end
    
    #modules and classes are understandibly quite similar   Class < Module
    rule( :module_name => simple(:module_name) , :module_expressions => sequence(:module_expressions) , :end=>"end") do
      Ast::ModuleExpression.new(module_name , module_expressions)
    end
    rule( :module_name => simple(:module_name) , :derived_name => simple(:derived_name) , :class_expressions => sequence(:class_expressions) , :end=>"end") do
      Ast::ClassExpression.new(module_name , derived_name ? derived_name.name : nil , class_expressions)
    end
    
    rule(:expression_list => sequence(:expression_list)) {
      Ast::ExpressionList.new(expression_list)
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
