require 'rest-client'
require 'json'

module FoostixApi
  @options = {}  
  class << self
    attr_accessor :options
  end
  
  private
  class DefaultAction
    def initialize      
      if !FoostixApi.options.has_key?(:api_key)
        raise "API KEY required"
      end
      if !FoostixApi.options.has_key?(:api_uri)
        raise "API URI required"
      end
    end
        
    def fetch_token
      RestClient.post(FoostixApi.options[:api_uri]+"/auth", JSON.generate({:api_key => FoostixApi.options[:api_key]}), {content_type: :json, accept: :json})
    end
  end
  
  public
  module Search
    module Geoportail
      class Locationsearch < DefaultAction
        def initialize
          super
        end
      end
    end
  end
end