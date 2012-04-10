module Mingle
  module MacroDevelopmentToolkit
    VERSION = '1.3.4'
  end
end

Gem::Specification.new do |spec|
  spec.name        = 'mingle-macro-development-toolkit'
  spec.version     = Mingle::MacroDevelopmentToolkit::VERSION
  spec.summary     = "This toolkit provides support for developing, testing and deploying custom Mingle macros."
  spec.description = "This toolkit provides support for developing, testing and deploying custom Mingle macros."
  spec.author      = "ThoughtWorks Inc"
  spec.email       = 'support@thoughtworks.com'
  spec.license     = 'MIT'
  spec.files       = Dir['**/*'] - Dir['*.gemspec']
  spec.test_files  = Dir['test/test_helper'] + Dir['test/unit/*.rb'] + Dir['test/data/fixtures/*']
  spec.add_runtime_dependency 'mingle_macro_models', '1.3.4'
  spec.add_runtime_dependency 'activesupport', '2.3.5'
  spec.homepage    = 'https://rubygems.org/gems/mingle-macro-development-toolkit'
  spec.executables << 'new_mingle_macro'
end
