require 'spec_helper'
require 'fixer/client/errors/invalid_response'

RSpec.describe Fixer::Client::Errors::InvalidResponse do

  describe "InvalidResponse" do 
    it "creates InvalidResponse error" do

      err = Fixer::Client::Errors::InvalidResponse.new("some error")

      expect(err.message).to eq "some error"
    end
  end

end