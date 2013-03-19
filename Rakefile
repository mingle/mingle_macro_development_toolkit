require "rake/testtask"
require 'rdoc/task'

namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test/unit"
    t.pattern = 'test/unit/*_test.rb'
    t.verbose = true
  end

  Rake::TestTask.new(:integration) do |t|
    t.libs << "test/integration"
    t.pattern = 'test/integration/*_test.rb'
    t.verbose = true
  end
end

RDoc::Task.new do |rdoc|
  rdoc.rdoc_files.include "README", "LICENSE", "lib/**/*.rb", "bin/**/*.rb"
end