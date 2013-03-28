require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rubygems/package_task'
require_relative 'lib/value/services/version'

CLOBBER.include('pkg', 'web/javascripts', 'web/stylesheets/app.css')

spec = Gem::Specification.new do |s|
  s.name    = "value-services"
  s.version = Value::Services::VERSION

  s.summary     = "A DSL that encapsulates the Value pattern in the form of executable components."
  s.description = "Value Services are dynamically generated data based on parameters and specifications.
Send a command to the service and it runs on every system in the group. Services, files
and permissions are managed via the bundled web application."

  s.authors      = ["Jeremy Hulick"]
  s.email        = %w[jeremy.hulick@gmail.com]
  s.homepage     = "http://www.netspective.com"

  s.test_files   = FileList["test/**/*"]
  s.executables  = %w[value-services]
  s.require_path = "lib"

  s.add_dependency "value", ">= 0.4.0"

  s.add_development_dependency "minitest"
  s.add_development_dependency "rake"

  s.required_ruby_version = '>= 1.9.2'
end

# Set gem file list after CoffeeScripts have been compiled, so web/javascripts/
# is included in the gem.
task :gemprep do
  spec.files = FileList['[A-Z]*', '{bin,lib,conf}/**/*']
  Gem::PackageTask.new(spec).define
  Rake::Task['gem'].invoke
end

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.warning = false
end

task :compile do

end

task :cleanup do
end

task :default => [:clobber, :test, :compile, :gemprep, :cleanup]
