module Soml

  def self.ast_to_code statement
    compiler = ToCode.new
    compiler.process statement
  end

  class ToCode < AST::Processor

    def on_while_statement statement
      #puts statement.inspect
      branch_type , condition , statements = *statement
      w = WhileStatement.new()
      w.branch_type = branch_type
      w.condition = process(condition) #.first
      w.statements = process_all(statements)
      w
    end

    def on_if_statement statement
      branch_type , condition , if_true , if_false = *statement
      w = IfStatement.new()
      w.branch_type = branch_type
      w.condition = process(condition) #.first
      w.if_true = process_all(if_true)
      w.if_false = process_all(if_false)
      w
    end

    def on_statements statement
      w = Statements.new()
      w.statements = process_all(statement.children)
      w
    end

    def on_return statement
      w = ReturnStatement.new()
      w.return_value = process(statement.children.first)
      w
    end

    def on_operator_value statement
      operator , left_e , right_e = *statement
      w = OperatorExpression.new()
      w.operator = operator
      w.left_expression = process(left_e)
      w.right_expression = process(right_e)
      w
    end

    def on_field_access statement
      receiver_ast , field_ast = *statement
      w = FieldAccess.new()
      w.receiver = process(receiver_ast)
      w.field = process(field_ast)
      w
    end

    def on_receiver expression
      process expression.children.first
    end

    def on_call statement
      name_s , arguments , receiver = *statement
      w = CallSite.new()
      w.name = name_s
      w.arguments = process(arguments)
      w.receiver = process(receiver)
      w
    end

    def on_int expression
      IntegerExpression.new(expression.children.first)
    end

    def on_true expression
      TrueExpression.new
    end

    def on_false expression
      FalseExpression.new
    end

    def on_nil expression
      NilExpression.new
    end

    def on_name statement
      NameExpression.new(statement.children.first)
    end
    def on_string expression
      StringExpression.new(expression.children.first)
    end

    def on_class_name expression
      ClassExpression.new(expression.children.first)
    end

    def on_assignment statement
      name , value = *statement
      w = Assignment.new()
      w.name = process name
      w.value = process(value)
      w
    end

  end
end
