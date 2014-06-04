module Ast
  class ModuleExpression < Expression

    attr_reader  :name ,:expressions

    def initialize name , expressions
      @name = name.to_sym
      @expressions = expressions
    end
    def inspect
      self.class.name + ".new(" + @name.inspect + " ," + @expressions.inspect + " )"  
    end
    def to_s
      "module #{name}\n #{expressions}\nend\n"
    end
    def attributes
      [:name , :expressions]
    end
  end

  class ClassExpression < ModuleExpression

  end
end