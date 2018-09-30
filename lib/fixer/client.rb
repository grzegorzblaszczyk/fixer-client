require "fixer/client/version"
require 'fixer/client/http_client'

module Fixer
  module Client
	  class << self
      HttpClient::SCOPES.each do |scope|
        define_method(scope) do
          HttpClient.new(scope)
        end
      end
    end
  end
end
