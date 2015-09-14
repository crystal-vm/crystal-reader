# abstract syntax tree (ast)
# This Layer is semi automagically created by parslet using the transform

# It in turn is responsible for the transformation to the next layer, vm code

# This happens in the compile function which must return a Vm::Code derivative

# PS: compare is only for tests and should be factored out to there

Array.class_eval do
  def to_basic
    collect do |item|
      item.to_basic
    end
  end
end
Symbol.class_eval do
  def to_basic
    to_s
  end
end
String.class_eval do
  def to_basic
    to_s
  end
end
module Ast
  class Expression
    def attributes
      raise "abstract called for #{self}"
    end
    def to_basic()
      data = { "class" => self.class.name }
      attributes.each do |name|
        val = instance_variable_get("@#{name}".to_sym)
        res = val.to_basic
        data[name] = res
      end
      data
    end

    def self.from_basic(hash)
      clazz = hash.delete("class")
      keys = hash.keys
      klass = clazz.split("::").inject(Object) {|o,c| o.const_get(c)}
      keys.delete("class")
      values = keys.collect{|k| read_basic(hash[k]) }
      klass.new(*values)
    end
    def self.read_basic val
      return from_basic(val) if val.is_a?(Hash)
      return val.collect{|i| from_basic(i)} if(val.is_a? Array )
      val
    end

    def inspect
      self.class.name + ".new(#{to_s})"
    end
    def == other
      return false unless other.class == self.class
      attributes.each do |a|
        left = send(a)
        right = other.send(a)
        return false unless left.class == right.class
        return false unless left == right
      end
      return true
    end
  end

end

require_relative "basic_expressions"
require_relative "call_site_expression"
require_relative "compound_expressions"
require_relative "if_expression"
require_relative "function_expression"
require_relative "module_expression"
require_relative "operator_expressions"
require_relative "return_expression"
require_relative "while_expression"
require_relative "expression_list"
