require_relative "setup"

# Included in parser test will create tests methods
module ParserHelper

  def self.included(base)
    base.send :include, InstanceMethods  #provides helpers and setup
    base.send :extend, ClassMethods   #gets the method creation going
  end

  module InstanceMethods
    def setup
      @parser = Keywords
    end

    # check that @string_input parses correctly to @parse_output
    def check_parse
      is = @parser.parse(@string_input , :root => @root)
      assert_equal @string_input , is
    end

    #check that @parse_output transforms to @transform_output
    def check_transform
      is = @transform.apply @parse_output
      #puts is.transform
      assert_equal @transform_output , is
    end

    # check that @string_input parses and transforms to @transform_output
    def check_ast
      syntax    = @parser.parse(@string_input , :root => @root)
      #puts is.inspect
      assert_equal @transform_output , syntax.value
    end
  end

  module ClassMethods
    # this creates test methods dynamically. For each test_* method we create
    # three test_*[ast/parse/transf] methods that in turn check the three phases.
    # runnable_methods is called by minitest to determine which tests to run
    def runnable_methods
      tests = []
      public_instance_methods(true).grep(/^test_/).map(&:to_s).each do |test|
        ["ast" , "parse"].each do |what|
          name = "#{test}_#{what}"
          tests << name
          self.send(:define_method, name ) do
            send(test)
            send("check_#{what}")
          end
        end
      end
      tests
    end
   end
end
