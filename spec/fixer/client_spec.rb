require_relative '../spec_helper'
require 'fixer/client'

RSpec.describe Fixer::Client do

  before do
    VCR.insert_cassette 'fixer'
  end

  after do
    VCR.eject_cassette
  end

  describe "#latest" do 
    it "gets latest Fixer.io rates for PLN, USD, GBP for base EUR currecy" do
      stub_request(:any, "data.fixer.io") unless ENV["VCR_OFF"] == "1"
      fixer_client = Fixer::Client.latest
      result = fixer_client.fetch(["PLN", "USD", "GBP"])
      expect(result["success"]).to eql true
      expect(result["timestamp"]).to be > 0
      expect(result["rates"]).not_to eql nil
      expect(result["rates"]["PLN"]).to be > 1
      expect(result["rates"]["USD"]).to be > 0
      expect(result["rates"]["GBP"]).to be > 0
    end

	  it "fails to get Fixer.io rates for PLN, USD, GBP for base EUR currecy for specific date using #latest client" do
	    fixer_client = Fixer::Client.latest
	    expect {
        fixer_client.fetch(["PLN", "USD", "GBP"], "2018-10-01")
      }.to raise_error(ArgumentError)
	  end
  end

  describe "#historical" do 
    it "fails to get historical Fixer.io rates for PLN, USD, GBP for base EUR currecy - not yet implemented" do
      fixer_client = Fixer::Client.historical
      expect {
        fixer_client.fetch(["PLN", "USD", "GBP"])     
      }.to raise_error(ArgumentError)
    end
  end

end