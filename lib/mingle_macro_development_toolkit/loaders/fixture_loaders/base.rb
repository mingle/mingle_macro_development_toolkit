#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
require "yaml"

module FixtureLoaders
  class Base
    def initialize(attributes)
      @attributes = attributes
    end
    
    def load_fixtures_for(name)
      path = File.join(FixtureLoaders::FIXTURE_PATH, "#{name}.yml")
      YAML::load(File.read(path))
    end
    
    def match?(record)
      @attributes.all? { |key, value| value == record[key] }
    end
  end
end
