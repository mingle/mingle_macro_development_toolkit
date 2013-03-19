#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class PropertyDefinitionsLoader
    include LoaderHelper

    def initialize(project)
      @project = project
    end

    def load
      extract('property_definitions', @project).collect { |pd| PropertyDefinitionLoader.new(@project, pd) }
    end
  end
end
