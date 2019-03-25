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

    def self.get_with_args(args={}, params)
      token = fetch_token
      
      path = @path
      args.each do |k,v|
        path = @path.gsub("{"+k.to_s+"}", v.to_s)
      end

      RestClient::Request.execute(:method => :get, :payload => params, :url => FoostixApi.options[:api_uri]+path, :headers => {Authorization: "Token token="+token}).body
    end
  end

  private
  class PostAction
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

    def self.post(args={}, params)
      token = fetch_token
      path = @path
      args.each do |k,v|
        path = @path.gsub("{"+k.to_s+"}", v.to_s)
      end

      RestClient::Request.execute(:method => :post, :payload => params, :url => FoostixApi.options[:api_uri]+path, :headers => {Authorization: "Token token="+token}).body
    end

  end

  public
  module Restaurant
    class ClearHoursCache < PostAction
      @path = '/restaurant/{id}/clearHoursCache'
    end
  end

  module Restaurants
    class ClearHoursCache < PostAction
      @path = '/restaurant/clearHoursCache'
    end
  end

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
      class DeliveryAll < DefaultAction
        @path = '/search/restaurants/delivery_all'
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
      class Pickup < DefaultAction
        @path = '/search/restaurants/pickup_all'
      end
      class PickupGenres < DefaultAction
        @path = '/search/restaurants/pickup_genres'
      end
      class Open < DefaultAction
        @path = '/restaurant/is_open'
      end
    end
  end

  module Order
    class CheckTime < DefaultAction
      @path = "/orders/{order_id}/{restaurant_id}/check_time/{minutes}"
    end
  end
end
