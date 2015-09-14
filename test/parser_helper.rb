require_relative "setup"

# Included in parser test will create tests methods
module ParserHelper

  def self.included(base)
#    base.send :include, InstanceMethods  #provides helpers and setup
  end

  def setup
    @parser = Bosl
  end

  def check rule = :root
    parse    = @parser.parse(@input , :root => rule)
    assert_equal @input , parse
    assert_equal @output , parse.value
  end
end
