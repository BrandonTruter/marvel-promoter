require "faraday"
require "json"

class MarvelApiClient
 def self.characters()
   url = "https://gateway.marvel.com/v1/public/characters"
   data = Faraday.get(url).body
   JSON.parse(data, symbolize_names: true)
   # create account for API key then use in request:
   # response = Faraday.get(url, {apikey: ''})
 end
end
