
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'salama-reader'

require "minitest"
require "minitest/autorun"

# for testing add expression as allowed root
# bit of a hack: the directory name should be passed as the root if the parse fails
# but moving on (and coming back)
Parser::Salama.class_eval do
  rule(:root_body)    {( class_definition | function_definition | expression  )}
end
