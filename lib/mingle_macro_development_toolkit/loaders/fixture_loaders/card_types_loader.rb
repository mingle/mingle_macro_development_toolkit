#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module FixtureLoaders
  class CardTypesLoader < Base
    def load
      load_fixtures_for('card_types').collect do |ct|
        CardTypeLoader.new('id' => ct['id']) if match?(ct)
      end.compact.sort_by { |loader| loader.card_type.position }
    end
  end
end
