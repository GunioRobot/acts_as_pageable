require 'rubygems'
require 'rake'
require 'active_record'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "acts_as_pageable"
    gem.summary = %Q{Another pagination solution for Ruby.}
    gem.email = "paulo.ahagon@gmail.com"
    gem.homepage = "http://github.com/pahagon/acts_as_pageable"
    gem.authors = ["Paulo Ahagon"]
    gem.add_dependency(%q<active_record>,[">= 2.1.0"])
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test' << 'test/models'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'lib' << 'test' << 'test/models'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
    test.rcov_opts = ["--text-summary", "--rails", "-x gem,TextMate", "--charset UTF8", "--html"]
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = "1.0.0"
  end
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "acts_as_pageable #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => [:test]
