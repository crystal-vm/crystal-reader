require_relative "setup"
require "parslet/convenience"



# Older test harness
module ParserHelper

  def self.included(base)
    base.send :include, InstanceMethods  #provides helpers and setup
    base.send :include, AST::if_true
    base.send :extend, ClassMethods   #gets the method creation going
  end

  module InstanceMethods
    def setup
      @parser    = Parser::Salama.new
      @transform = Parser::Transform.new
    end

    # check that @string_input parses correctly to @parse_output
    def check_parse
      is = @parser.parse_with_debug(@string_input)
      assert_equal @parse_output , is
    end

    #check that @parse_output transforms to @transform_output
    def check_transform
      is = @transform.apply @parse_output
      #puts is.transform
      assert_equal @transform_output , is
    end

    # check that @string_input parses and transforms to @transform_output
    def check_ast
      syntax    = @parser.parse(@string_input)
      is      = @transform.apply(syntax)
      puts is.inspect
      assert_equal @transform_output , is
    end

    def check_write test
      dirname = decamelize(self.class.name)[10 .. -1]
      test = test[5 .. -1]
      syntax    = @parser.parse_with_debug(@string_input)
      out = Parser::Transform.new.apply(syntax).inspect
      dir = File.dirname(__FILE__) + "/" + dirname
      FileUtils.mkdir_p(dir) unless File.exists?(dir)
      out_file = File.new(dir + "/" + test + ".tst", "w")
      out_file.puts @string_input
      out_file.puts "-- -- --"
      out_file.puts out
      out_file.close
    end

    def decamelize str
        str.gsub(/(^|[a-z])([A-Z])/) do
          ($1.empty?)? $2 : "#{$1}_#{$2}"
        end.downcase
    end

    def camelize str
      str.gsub(/(^|_)([a-z])/) { $2.upcase }
    end
  end


  module ClassMethods
    # this creates test methods dynamically. For each test_* method we create
    # three test_*[ast/parse/transf] methods that in turn check the three phases.
    # runnable_methods is called by minitest to determine which tests to run
    def runnable_methods
      tests = []
      public_instance_methods(true).grep(/^test_/).map(&:to_s).each do |test|
        ["write"].each do |what|
          name = "#{test}_#{what}"
          tests << name
          self.send(:define_method, name ) do
            send(test)
            send("check_#{what}" , test)
          end
        end
      end
      tests
    end
   end
end
