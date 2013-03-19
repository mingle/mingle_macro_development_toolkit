#Copyright 2007 - 2013 ThoughtWorks, Inc.  All rights reserved.
module RESTfulLoaders
  class CardTypesLoader
    include LoaderHelper

    def initialize(project)
      @project = project
    end

    def load
      extract('card_types', @project).collect { |ct| CardTypeLoader.new(@project, ct) }.sort_by { |loader| loader.card_type.position }
    end
  end
end
