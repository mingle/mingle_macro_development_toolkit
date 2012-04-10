#Copyright 2012 ThoughtWorks, Inc.  All rights reserved.
require 'delegate'
require 'uri'
require 'net/http'
require 'thread'
require 'active_support'

module RESTfulLoaders

  class RemoteError < StandardError
    def self.parse(response_body)
      Hash.from_xml(response_body)['errors'].delete("error")
    end
  end

  module LoaderHelper

    def extract(key, container)
      container[key] ? container[key][key.singularize] : []
    end

    def get(resource)
      url = URI.parse(resource)
      get_request = Net::HTTP::Get.new(url.request_uri)
      get_request.basic_auth(url.user, url.password)
      response = Net::HTTP.start(url.host, url.port) { |http| http.request(get_request) }
      if response.code.to_s != "200"
        raise RemoteError, RemoteError.parse(response.body)
      end
      Hash.from_xml(response.body)
    end
  end

  class MqlExecutor < SimpleDelegator
    include LoaderHelper

    def initialize(resource, error_handler, delegator)
      super(delegator)
      @uri = URI.parse(resource)
      @error_handler = error_handler
      @version = /(\/api\/([^\/]*))\//.match(@uri.request_uri)[2]
    end

    def execute_mql(mql)
      from_xml_data(get(url_for(:action => "execute_mql", :query => "mql=#{mql}")))
    rescue => e
      @error_handler.alert(e.message)
      []
    end

    def can_be_cached?(mql)
      from_xml_data(get(url_for(:action => "can_be_cached", :query => "mql=#{mql}")))
    rescue => e
      @error_handler.alert(e.message)
      []
    end

    def format_number_with_project_precision(number)
      from_xml_data(get(url_for(:action => "format_number_to_project_precision", :query => "number=#{number}")))
    rescue => e
      @error_handler.alert(e.message)
      []
    end

    def format_date_with_project_date_format(date)
      from_xml_data(get(url_for(:action => "format_string_to_date_format", :query => "date=#{date}")))
    rescue => e
      @error_handler.alert(e.message)
      []
    end

    def url_for(params)
      relative_path = URI.escape("/api/#{@version}/projects/#{identifier}/cards/#{params[:action]}.xml?#{params[:query]}")
      @uri.merge(relative_path).to_s
    end

    def from_xml_data(data)
      if data.is_a?(Hash) && data.keys.size == 1
        from_xml_data(data.values.first)
      else
        data
      end
    end
  end
end
