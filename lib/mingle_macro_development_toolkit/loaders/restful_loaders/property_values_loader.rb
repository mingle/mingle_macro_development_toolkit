#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class PropertyValuesLoader
    include LoaderHelper

    def initialize(property_definition)
      @property_definition = property_definition
    end

    def load
      extract('values', @property_definition).collect {|value| Mingle::PropertyValue.new(OpenStruct.new(value))}
    end
  end
end
