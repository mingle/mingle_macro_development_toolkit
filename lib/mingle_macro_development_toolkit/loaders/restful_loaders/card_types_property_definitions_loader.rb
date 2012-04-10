#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class CardTypesPropertyDefinitionsLoader
    include LoaderHelper

    def initialize(project, params)
      @project = project
      @params = params
    end

    def load
      mappings = extract('card_types', @project).collect do |card_type|
        mapping = card_type['card_types_property_definitions'].values
      end.flatten

      pds = extract('property_definitions', @project)
      cts = extract('card_types', @project)
      mappings.collect do |mapping|
        if (match?(mapping))
          pd = pds.find { |pd| pd['id'] && pd['id'] == mapping['property_definition_id'] }
          ct = cts.find { |ct| ct['id'] == mapping['card_type_id'] }
          OpenStruct.new(:card_type => CardTypeLoader.new(@project, ct).load, :property_definition => PropertyDefinitionLoader.new(@project, pd).load)
        end
      end.compact
    end

    private
      def match?(mapping)
        @params.all? { |key, value| value == mapping[key] }
      end
  end
end
