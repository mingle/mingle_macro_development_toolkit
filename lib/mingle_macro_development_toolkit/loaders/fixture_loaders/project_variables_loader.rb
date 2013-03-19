#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module FixtureLoaders
  class ProjectVariablesLoader < Base
    def load
      load_fixtures_for('project_variables').collect do |pv|
        Mingle::ProjectVariable.new(OpenStruct.new(pv)) if match?(pv)
      end.compact
    end
  end
end
