#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
module FixtureLoaders
  class CardTypesPropertyDefinitionsLoader < Base
    def load
      load_fixtures_for('property_type_mappings').collect do |mapping|
        pd = PropertyDefinitionLoader.new('id' => mapping['property_definition_id']) if match?(mapping)
        ct = CardTypeLoader.new('id' => mapping['card_type_id']) if match?(mapping)
        OpenStruct.new(:card_type => ct.load, :property_definition => pd.load) if ct && pd
      end.compact
    end
  end
end
