require 'parslet'
require 'parser/salama'
require "ast"
require 'parser/transform'

AST::Node.class_eval do

  def [](name)
    puts self.inspect
    children.each do |child|
      if child.is_a?(AST::Node)
        puts child.type
        if (child.type == name)
          return child.children
        end
      else
        puts child.class
      end
    end
    nil
  end
end
