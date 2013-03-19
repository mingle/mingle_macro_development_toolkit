#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class ProjectVariablesLoader
    include LoaderHelper

    def initialize(project)
      @project = project
    end

    def load
      extract('project_variables', @project).collect {|pv| Mingle::ProjectVariable.new(OpenStruct.new(pv))}
    end
  end
end
