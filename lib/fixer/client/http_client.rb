require "net/http"
require "json"
require "pry"
require "fixer/client/errors/invalid_response"
require "yaml"

module Fixer
  module Client
    class HttpClient

      BASE_URI = "http://data.fixer.io/api"
      SCOPES = [
    	  :latest,
        :historical
  	  ].freeze
    	
  	  def initialize(scope = :latest)
        raise ::ArgumentError.new unless SCOPES.include?(scope)
  	    @scope = scope

        config_file = "config/fixerio_client.yml"
        @config = File.exist?(config_file) ? YAML.load_file(config_file) : default_config

        @api_key = nil
        if Kernel.const_defined?("Rails") && !Rails.env.nil? && @config["enabled_environments"].include?(Rails.env)
          @api_key = @config["api_key"]
        else
          @api_key = @config["api_key"]
        end
  	  end 

  	  def fetch(symbols = [], date = nil)
        raise ::ArgumentError.new("You cannot put date argument for 'latest' mode client") if @scope == :latest && !date.nil? && !date.empty?
        response_hash = hash(symbols)
        raise Fixer::Client::Errors::InvalidResponse.new("Response: #{response_hash}") if response_hash["success"].to_s != "true"
        response_hash
  	  end

      private 

        def hash(symbols)
          ::JSON.parse(json(symbols))
        end

        def json(symbols)
          Net::HTTP.get(url(symbols))
        end

        def url(symbols)
          symbols_arg = symbols.join(",")
          case @scope
          when :latest
            URI("#{BASE_URI}/latest?access_key=#{@api_key}&symbols=#{symbols_arg}")
          when :historical
            raise ::ArgumentError.new("Not implemented yet!")
          end
        end

        def default_config
          hash = {}
          hash["api_key"] = 'invalid_key'
          hash["enabled_environments"] = ['production', 'deelopment', 'test']
          hash
        end
    end
  end
end
