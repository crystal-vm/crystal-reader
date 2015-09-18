require_relative "setup"
require "parslet/convenience"
require "ast/sexp"

class TestAll <  MiniTest::Test
  include AST::Sexp

  def check_file file
    inn , out = File.new(file).read.split("-- -- --")
    sexp = eval(out)
    syntax    = Parser::Salama.new.parse_with_debug(inn)
    result = Parser::Transform.new.apply(syntax)
    equal = (sexp ==  result)
    puts "\n" + result.inspect unless equal
    assert_equal sexp ,  result
  end

  # this creates test methods dynamically. For each test_* method we create
  # three test_*[ast/parse/transf] methods that in turn check the three phases.
  # runnable_methods is called by minitest to determine which tests to run
  def self.runnable_methods
    puts "called"
    all = Dir["test/cases/*/*.tst"]
    puts "case #{all.length}"
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
