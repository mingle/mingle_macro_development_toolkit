#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class PropertyDefinitionLoader
    def initialize(project, pd)
      @project = project
      @pd = pd
    end

    def property_definition
      @property_definition ||= load
    end

    def load
      @property_definition = Mingle::PropertyDefinition.new(OpenStruct.new(@pd))
      @property_definition.card_types_property_definitions_loader = CardTypesPropertyDefinitionsLoader.new(@project, 'property_definition_id' => @pd['id'])
      @property_definition.values_loader = PropertyValuesLoader.new(@pd)
      @property_definition
    end
  end
end
