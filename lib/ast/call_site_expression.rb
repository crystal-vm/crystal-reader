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
end