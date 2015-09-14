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

  class TypedName < NameExpression
    attr_reader  :type
    def initialize type , name
      super(name)
      @type = type.to_sym
    end
    def attributes
      [:type, :name]
    end
    def inspect
      "#{self.class.name}.new(#{type.inspect},#{name.inspect})"
    end
    def to_s
      inspect
    end
  end

  class VariableDefinition < TypedName
    attr_reader  :right

    def initialize type , name , right
      super(type , name)
      @right = right
    end
    def attributes
      super + [:right]
    end
    def inspect
      self.class.name + ".new(" +  type.inspect + "," + name.inspect + "," + right.inspect + ")"
    end
    def to_s
      inspect
    end
  end

  class VariableExpression < NameExpression
  end

  class AssignmentExpression < NameExpression
    attr_reader  :right

    def initialize name, right
      super(name)
      @right = right
    end
    def attributes
      super + [:right]
    end
    def inspect
      self.class.name + ".new(" +  name.inspect + "," + right.inspect + ")"
    end
    def to_s
      "#{left} = #{right}"
    end
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
