require_relative '../..//spec_helper'
require 'fixer/client/http_client'

RSpec.describe Fixer::Client::HttpClient do

  before do
  end

  after do
  end

  describe "#initialize" do 
    it "gets proper API key and config after initialize without arguments passed" do
      http_client = Fixer::Client::HttpClient.new
      expect(http_client.send(:get_api_key)).to eq "invalid_key"
    end

    it "gets proper API key and config after initialize with agrument passed" do
      http_client = Fixer::Client::HttpClient.new(:latest)
      expect(http_client.send(:get_api_key)).to eq "invalid_key"
    end
  end

end