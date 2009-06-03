require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "acts_as_pageable"
    gem.summary = %Q{Another pagination solution for Ruby.}
    gem.email = "paulo.ahagon@gmail.com"
    gem.homepage = "http://github.com/pahagon/acts_as_pageable"
    gem.authors = ["Paulo Ahagon"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc "Run all tests"
require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test' 
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end

desc "Run code-coverage analysis using rcov"
install_gem('rcov', '-s http://gem.github.com') if Gem::SourceIndex.from_installed_gems.search('rcov').empty?
begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test' 
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

def install_gem(*args)
  cmd = []
  cmd << "#{'sudo ' unless Gem.win_platform?}gem install --no-ri --no-rdoc"
  sh cmd.push(*args.flatten).join(" ")
end

DEPENDENCIES = []
DEPENDENCIES << Gem::Dependency.new('thoughtbot-shoulda', '>=2.0')
desc 'Install the required dependencies'
task :setup do
  installed = Gem::SourceIndex.from_installed_gems
  DEPENDENCIES.select { |dep|
    installed.search(dep.name, dep.version_requirements).empty? }.each do |dep|
      puts "Installing #{dep} ..."
      install_gem dep.name, "-v '#{dep.version_requirements.to_s}'"
    end
end

