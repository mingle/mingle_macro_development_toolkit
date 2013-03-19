#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module FixtureLoaders
  class PropertyValuesLoader < Base
    def load
      load_fixtures_for('property_values').collect do |pv|
        Mingle::PropertyValue.new(OpenStruct.new(pv)) if match?(pv)
      end.compact
    end
  end
end
