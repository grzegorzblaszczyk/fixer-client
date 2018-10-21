require_relative '../../spec_helper'
require 'fixer/client/http_client'

RSpec.describe Fixer::Client::HttpClient do

  before do
  end

  after do
  end

  describe "#initialize" do 
    it "gets proper API key and config after initialize without arguments passed" do
      http_client = Fixer::Client::HttpClient.new
      expect(http_client.send(:get_api_key)).to eq get_api_key_from_config("./#{Fixer::Client::HttpClient::CONFIG_FILE}") if ENV["VCR_OFF"] == "1" 
      expect(http_client.send(:get_api_key)).to eq "invalid_key" unless ENV["VCR_OFF"] == "1" 
    end

    it "gets proper API key and config after initialize with agrument passed" do
      http_client = Fixer::Client::HttpClient.new(:latest)
      expect(http_client.send(:get_api_key)).to eq get_api_key_from_config("./#{Fixer::Client::HttpClient::CONFIG_FILE}") if ENV["VCR_OFF"] == "1" 
      expect(http_client.send(:get_api_key)).to eq "invalid_key" unless ENV["VCR_OFF"] == "1" 
    end
  end

  describe "#default_config" do 
    it "gets default_config" do
      http_client = Fixer::Client::HttpClient.new
      default_config = http_client.send(:default_config)
      expect(default_config["api_key"]).to eq "invalid_key" 
      expect(default_config["enabled_environments"]).to eq ['production', 'development', 'test'] 
    end
  end

end