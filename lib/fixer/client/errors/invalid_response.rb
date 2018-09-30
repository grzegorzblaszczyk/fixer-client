module Fixer
  module Client
  	module Errors
      class InvalidResponse < StandardError
  		def initialize(msg="Invalid response from API")
    	  super
  		end
  	  end
  	end
  end
end