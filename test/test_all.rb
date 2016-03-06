require_relative "setup"
require "parslet/convenience"
require "ast/sexp"
require "pp"

class TestAll <  MiniTest::Test
  include AST::Sexp
  SEPERATOR = "-- -- --"

  def check_file file
    inn , out = File.new(file).read.split(SEPERATOR)
    sexp = eval(out)
    begin
      syntax    = Parser::Salama.new.parse(inn)
    rescue
      root = file.split("/")[2]
      parser = Parser::Salama.new.send root.to_sym
      syntax    = parser.parse_with_debug(inn )
    end
    result = Parser::Transform.new.apply(syntax)
    equal = (sexp == result)
    unless equal
      if ENV["FIX"]
        out_file = File.new(file, "w")
        out_file.puts inn
        out_file.puts SEPERATOR
        out_file.puts result.inspect
        out_file.close
        puts "Fixed #{file}"
        sexp = result
      else
        pp  syntax
        puts result.inspect
      end
    end
    assert_equal sexp ,  result
    check_transform sexp
  end

  def check_transform sexp
    code = Soml.ast_to_code sexp
    assert code.is_a?(Soml::Code) , "Returned #{code}"
  end

  # this creates test methods dynamically. For each test_* method we create
  # three test_*[ast/parse/transf] methods that in turn check the three phases.
  # runnable_methods is called by minitest to determine which tests to run
  def self.runnable_methods
    all = Dir["test/cases/*/*.tst"]
    tests =[]
    all.each do |file|
      name = file.sub("test/cases/","").sub("/","_").sub(".tst","")
      tests << name
      self.send(:define_method, name ) do
        send("check_file" , file)
      end
    end
    tests
  end
end
