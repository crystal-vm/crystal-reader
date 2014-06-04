module Ast
  # assignment, like operators are really function calls
  
  class CallSiteExpression < Expression
    attr_reader  :name, :args , :receiver

    def initialize name, args , receiver = Ast::NameExpression.new(:self)
      @name = name.to_sym
      @args = args 
      @receiver =  receiver
    end
    
    def inspect
      self.class.name + ".new(" + name.inspect + ", ["+ 
        args.collect{|m| m.inspect }.join( ",") + "] ," + receiver.inspect  + ")"  
    end
    def to_s
      "#{name}(" + args.join(",") + ")"
    end
    def attributes
      [:name , :args , :receiver]
    end
  end
  
  class VariableExpression < CallSiteExpression

    def initialize name
      super( :_get_instance_variable  , [StringExpression.new(name)] )
    end
    def inspect
      self.class.name + ".new(" + args[0].string.inspect + ")"  
    end

  end
  
end