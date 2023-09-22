require 'rake/testtask'
require 'rake/notes/rake_task'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
end

namespace :challenge do
  require './challenge'

  desc "Run challenge and print to console"
  task :console do
    Runner.new('console').process
  end

  desc "Run challenge and generate output.txt"
  task :txt do
    Runner.new('txt').process
  end
end

task default: :test
