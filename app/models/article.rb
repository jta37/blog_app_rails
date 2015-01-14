class Article < ActiveRecord::Base
	require './alchemyapi'
	alchemyapi = AlchemyAPI.new()

	# This will help with accessing keywords 
	attr_accessor :keywords
	@@alchemy_url ||= ENV["ALCHEMY_URL"]

	def make_request
    request = Typhoeus::Request.new(
      "http://access.alchemyapi.com/calls/text/TextGetRankedKeywords",
      method: :get,
      params: { apikey: ENV["ALCHEMY_APIKEY"],
                text: self.description,
                maxRetrieve: 10, 
                keywordExtractMode: "normal",
                outputMode: 'json',  },
      headers: { Accept: "text/html" }
    )

    request.run

	  response = request.response
	  puts response.body	
	  puts " ============== "
	  extractedJSON = response.body
	  parsedJSON = JSON.parse(extractedJSON)
	  puts "----------------"
	  keywords = parsedJSON["keywords"]
	  puts keywords

	  return keywords


    # puts response.body
    # puts " ============== "
    # puts response.code
    # puts response.code

    # puts response.total_time
    # puts response.headers
    # puts response.body
  end
end
