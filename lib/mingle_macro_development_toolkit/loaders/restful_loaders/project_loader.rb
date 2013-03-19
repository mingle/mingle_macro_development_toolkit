#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class ProjectLoader
    include LoaderHelper

    def initialize(resource, error_handler)
      @resource = resource
      @error_handler = error_handler
    end

    def project
      @project ||= load
    end

    private
      def load
        proj = OpenStruct.new(get(@resource)).project
        project = MqlExecutor.new(@resource, @error_handler, Mingle::Project.new(OpenStruct.new(proj), nil))
        project.card_types_loader = CardTypesLoader.new(proj)
        project.property_definitions_loader = PropertyDefinitionsLoader.new(proj)
        project.team_loader = TeamLoader.new(proj)
        project.project_variables_loader = ProjectVariablesLoader.new(proj)
        project
      end
  end
end
