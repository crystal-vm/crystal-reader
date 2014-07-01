# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "crystal-reader"
  gem.homepage = "http://github.com/crystal-vm/crystal-reader"
  gem.license = "GPL3"
  gem.summary = %Q{Parse ruby in ruby using parslet.}
  gem.description = %Q{Crystal reader is part of the crystal vm. The reader reads (parses) ruby and
               creates an ast from it. There are no other dependencies than parslet, which itself has hardly any.
             The gem may be useful for code analysis tools or for education.
           Two ways to use it include adding functions to each of the AST classes, or using a visitor patter.}
  gem.email = "torsten@villataika.fi"
  gem.authors = ["Torsten Ruger"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "crystal-reader #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
