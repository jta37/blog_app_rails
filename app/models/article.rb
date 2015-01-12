class Article < ActiveRecord::Base
	require './alchemyapi'
	alchemyapi = AlchemyAPI.new()

	# def make_request
 #  	res = Typhoeus.get("www.google.com/search", {
 #        params: {
 #          q:  @name
 #        }
 #      })
 #    res.body
 #  end

 


def make_request
    request = Typhoeus::Request.new(
      "http://access.alchemyapi.com/calls/text/TextGetRankedKeywords",
      method: :get,
      params: { apikey: "fa2f5defffeb15bc53e8cc1d2f5e751e0e9c8c99",
                text: description,
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
