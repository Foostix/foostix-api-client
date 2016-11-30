require 'rest-client'
require 'json'

module FoostixApi
  @options = {}
  @token = nil

  class << self
    attr_accessor :options
  end
  
  private
  class DefaultAction
    @path = nil
    def self.initialize      
      if !FoostixApi.options.has_key?(:api_key)
        raise "API KEY required"
      end
      if !FoostixApi.options.has_key?(:api_uri)
        raise "API URI required"
      end
    end
        
    def self.fetch_token
      if @token.nil? || Time.parse(@token["expires_at"]) < Time.now()
        response = RestClient.post(FoostixApi.options[:api_uri]+"/auth", JSON.generate({:api_key => FoostixApi.options[:api_key]}), {content_type: :json, accept: :json})                
        @token = JSON.parse(response.body)
      end
      return @token["token"]
    end

    def self.get(params)
      token = fetch_token
      RestClient::Request.execute(:method => :get, :payload => params, :url => FoostixApi.options[:api_uri]+@path, :headers => {Authorization: "Token token="+token}).body
    end
  end
  
  public
  module Search
    module Geoportail
      class Locationsearch < DefaultAction
        @path = '/search/geoportail/locationsearch'
      end

      class Getfeature < DefaultAction
        @path = '/search/geoportail/getfeature'
      end
    end

    module Restaurants
      class Delivery < DefaultAction
        @path = '/search/restaurants/delivery'
      end
      class DeliveryGenres < DefaultAction
        @path = '/search/restaurants/delivery_genres'
      end
      class DeliveryTimes < DefaultAction
        @path = '/search/restaurants/delivery_times'
      end
      class DeliveryFees < DefaultAction
        @path = '/search/restaurants/delivery_fees'
      end
      class Pickup < DefaultAction
        @path = '/search/restaurants/pickup'
      end
      class PickupGenres < DefaultAction
        @path = '/search/restaurants/pickup_genres'
      end
    end
  end


end