#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module FixtureLoaders
  class PropertyDefinitionLoader < Base
    def property_definition
      @property_definition ||= load
    end

    def load
      record = load_fixtures_for('property_definitions').find { |pd| match?(pd)}
      property_definition = Mingle::PropertyDefinition.new(OpenStruct.new(record))
      property_definition.card_types_property_definitions_loader = CardTypesPropertyDefinitionsLoader.new('property_definition_id' => record['id'])
      property_definition.values_loader = PropertyValuesLoader.new('property_definition_id' => record['id'])
      property_definition
    end
  end
end
