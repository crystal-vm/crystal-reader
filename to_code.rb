require 'rubygems'
require 'bundler'

Bundler.setup(:default, :development)

require 'soml-parser'
require "parslet/convenience"
require "ast/sexp"
require "pp"

class Converter
  include AST::Sexp
  SEPERATOR = "-- -- --"

  def to_ast
    file = ARGV[0]
    inn = File.new(file).read.split(SEPERATOR).first
    begin
      syntax  = Parser::Salama.new.parse(inn)
    rescue
      root    = file.split("/").last.split(".").first
      parser  = Parser::Salama.new.send root.to_sym
      syntax  = parser.parse_with_debug(inn )
    end
    result = Parser::Transform.new.apply(syntax)

    out_file = File.new(file, "w")
    out_file.puts inn
    out_file.puts SEPERATOR
    out_file.puts result.inspect
    out_file.close
  end

end

Converter.new.to_ast
