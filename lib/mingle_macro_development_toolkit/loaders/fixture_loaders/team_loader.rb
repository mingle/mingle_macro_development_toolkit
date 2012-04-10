#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
module FixtureLoaders
  class TeamLoader < Base
    def load
      load_fixtures_for('users').collect do |user|
        Mingle::User.new(OpenStruct.new(user)) if match?(user)
      end.compact
    end
  end
end
