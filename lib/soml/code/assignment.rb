module Soml
  class Assignment < Statement
    attr_accessor :name , :value
  end

  class FieldDef < Statement
    attr_accessor :name , :type , :value
  end

end
