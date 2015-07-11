# collection of the simple ones, int and strings and such

module Ast

  class IntegerExpression < Expression
    attr_reader :value
    def initialize val
      @value = val
    end
    def attributes
      [:value]
    end
    def inspect
      self.class.name + ".new(" + value.to_s+ ")"
    end
    def to_s
      value.to_s
    end
  end

  class TrueExpression < Expression
    def to_s
      "true"
    end
  def attributes
    []
  end
  end
  class FalseExpression < Expression
    def to_s
      "false"
    end
    def attributes
      []
    end
  end
  class NilExpression < Expression
    def to_s
      "nil"
    end
    def attributes
      []
    end
  end

  class NameExpression < Expression
    attr_reader  :name
    def initialize name
      @name = name.to_sym
    end
    def attributes
      [:name]
    end
    def inspect
      "#{self.class.name}.new(#{name.inspect})"
    end
    def to_s
      name.to_s
    end
  end

  class VariableExpression < NameExpression
  end

  class ModuleName < NameExpression
  end

  class StringExpression < Expression
    attr_reader  :string
    def initialize str
      @string = str
    end
    def attributes
      [:string]
    end
    def inspect
      self.class.name + '.new("' + string + '")'
    end
    def to_s
      '"' + string.to_s + '"'
    end
  end

end
