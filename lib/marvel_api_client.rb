require 'digest/md5'
require "faraday"
require "json"

class MarvelApiClient
  def self.set_md5(ts)
    md5 = Digest::MD5.new
    pub_key = "5f3ca374aec85caae447eff6ff94fed3"
    pvt_key = "f10bc178862ee730c312491f165d4cc36d22d77c" # MOVE THIS TO CONFIG & GITIGNORE
    _md5 = md5.update "#{ts}#{pvt_key}#{pub_key}"
    _md5.hexdigest
  end

  def self.characters()
    timestamp = Time.now
    api_hash = set_md5(timestamp)
    api_key = "5f3ca374aec85caae447eff6ff94fed3"
    url = "https://gateway.marvel.com/v1/public/characters"
    response = Faraday.get(url, {apikey: api_key, ts: timestamp, hash: api_hash})
    JSON.parse(response.body, symbolize_names: true)
  end
end
