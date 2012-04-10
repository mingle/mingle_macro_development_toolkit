#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
module FixtureLoaders
  class CardTypeLoader < Base
    def card_type
      @card_type ||= load
    end

    def load
      record = load_fixtures_for('card_types').find {|ct| match?(ct)}
      card_type = Mingle::CardType.new(OpenStruct.new(record))
      card_type.card_types_property_definitions_loader = CardTypesPropertyDefinitionsLoader.new('card_type_id' => record['id'])
      card_type
    end
  end
end
