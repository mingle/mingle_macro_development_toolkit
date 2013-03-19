#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module FixtureLoaders
  class PropertyDefinitionsLoader < Base
    def load
      load_fixtures_for('property_definitions').collect do |pd|
        PropertyDefinitionLoader.new('id' => pd['id']) if match?(pd)
      end.compact
    end
  end
end
