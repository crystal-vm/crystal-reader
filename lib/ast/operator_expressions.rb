module Ast
    
  class OperatorExpression < Expression
    attr_reader  :operator, :left, :right

    def initialize operator, left, right
      @operator, @left, @right = operator, left, right
    end
    def attributes
      [:operator, :left, :right]
    end
    def inspect
      self.class.name + ".new(" + operator.inspect + ", " +  left.inspect + "," + right.inspect + ")"  
    end
    def to_s
      "#{left} #{operator} #{right}"
    end
  end

  class AssignmentExpression < Expression
    attr_reader  :left, :right

    def initialize left, right
      @left, @right = left, right
    end
    def attributes
      [:left, :right]
    end
    def inspect
      self.class.name + ".new(" +  left.inspect + "," + right.inspect + ")"  
    end
    def to_s
      "#{left} = #{right}"
    end
  end

end
