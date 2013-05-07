#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class TeamLoader
    include LoaderHelper

    def initialize(project)
      @project = project
    end

    def load
      (extract('users', @project) || []).collect{ |user| Mingle::User.new(OpenStruct.new(user))}
    end
  end
end
