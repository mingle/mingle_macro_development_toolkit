#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
require "ostruct"

module FixtureLoaders
  class ProjectLoader < Base
    attr_reader :project
    def initialize(identifier)
      project_attributes = load_fixtures_for('projects').detect {|project| project['identifier'] == identifier }
      @project = Mingle::Project.new(OpenStruct.new(project_attributes), nil)
      project.card_types_loader = CardTypesLoader.new('project_id' => project_attributes['id'])
      project.property_definitions_loader = PropertyDefinitionsLoader.new('project_id' => project_attributes['id'])
      project.team_loader = TeamLoader.new('project_id' => project_attributes['id'])
      project.project_variables_loader = ProjectVariablesLoader.new('project_id' => project_attributes['id'])
    end
  end
end
