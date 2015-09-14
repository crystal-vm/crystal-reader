module Ast
  class ModuleExpression < Expression

    attr_reader  :name ,:expressions

    def initialize name , expressions
      @name = name.to_sym
      @expressions = expressions
    end
    def attributes
      [:name , :expressions]
    end

    def to_s
      name.inspect + " ," + expressions.inspect
    end
  end

  class ClassExpression < ModuleExpression

    def initialize name , derived , expressions
      super(name , expressions)
      @derived_from = derived
    end
    def attributes
      [:name , :derived_from , :expressions]
    end

    def derived_from
      @derived_from ? @derived_from : :Object
    end
    
    def to_s
      name.inspect + " ," + derived_from.inspect + ", " + expressions.inspect
    end
  end
end
