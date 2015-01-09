class Article < ActiveRecord::Base
	def make_request
  	res = Typhoeus.get("www.google.com/search", {
        params: {
          q:  @name
        }
      })
    res.body
  end
end
