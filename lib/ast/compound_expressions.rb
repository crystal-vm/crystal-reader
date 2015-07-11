module Ast

  class ArrayExpression < Expression
    attr_reader :values
    def attributes
      [:values]
    end
    def initialize vals
      @values = vals
    end
    def inspect
      self.class.name + ".new(" + values.to_s+ ")"
    end
  end

  class AssociationExpression < Expression
    attr_reader :key , :value
    def initialize key , value
      @key , @value = key , value
    end
    def attributes
      [:key , :value]
    end
    def inspect
      self.class.name + ".new(" + key.inspect + " , " + value.inspect + ")"
    end

  end
  class HashExpression < ArrayExpression
  end
end
