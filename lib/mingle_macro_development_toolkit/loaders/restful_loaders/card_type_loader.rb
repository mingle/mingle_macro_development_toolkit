#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class CardTypeLoader
    def initialize(project, ct)
      @project = project
      @ct = ct
    end

    def card_type
      @card_type ||= load
    end

    def load
      card_type = Mingle::CardType.new(OpenStruct.new(@ct))
      card_type.card_types_property_definitions_loader = CardTypesPropertyDefinitionsLoader.new(@project, 'card_type_id' => @ct['id'])
      card_type
    end
  end
end
