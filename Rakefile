require 'bundler/gem_tasks'
require 'yard'

desc "Test the things"
require 'vault-test-tools/rake_task'

desc "Doc the things"
YARD::Rake::YardocTask.new

desc "Run the test suite"
task :default => [:test]
