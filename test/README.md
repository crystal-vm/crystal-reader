##Running Tests

To run all tests, type

    ruby test/test_all.rb

to run just a single, replace all with what you want to test. Minitest accept a -n option to run just a single test. So while developing i often write things like

    ruby test/test_class.rb -n test_class_ops_parse

Notice tough the "_parse" at the end, while you will find no such function. The Magic (explained below) renerates three
functions per case. Your options are "_parse" , "_transform" , or if it's really bad, "_ast" (this should really work when the previous two work)

### Directories

Currently we have two directories for test.

- unit tests map to parser modules and specify the parser rule they test
- root test test much of the same functionality, but as root (rule) tests.

The root tests need to be separate to check if separate rules interfere with each other.

Apart from just plain more tests, two additional directories are planned. One is larger tests and the other is failing tests.

###Parsing

Parsing is a two step process with parslet:
  - parse takes an input and outputs hashes/arrays with basic types
  - tramsform takes the output of parse and generates an ast (as specified by the transformation)

A test tests both phases separately and again together.
Each test must thus specify (as instance variables):
- the string input
- the parse output
- the transform output

### Magic

Test are grouped by functionality into cases (classes) and define methods test_*
Test cases must include ParserHelper, which includes the magic to write the 3 test methods for each
test method. See test_basic for easy example.

Example:

  def test_number
    @string_input    = '42 '
    @test_output = {:integer => '42'}
    @transform_output = Parser::IntegerExpression.new(42)
    @parser = @parser.integer
  end

The first three lines define the data as described above.
The last line tells the parser what to parse. This is off couse only needed when a non-root rule is tested
and should be left out if possible.

As can be seen, there are no asserts. All asserting is done by the created methods, which call
the check_* methods in helper.
