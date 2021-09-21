require 'digest/md5'
require "faraday"
require "json"

class MarvelApiClient
  def self.set_md5(ts)
    md5 = Digest::MD5.new
    api_config = MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]
    pub_key = api_config["public_key"]
    pvt_key = api_config["private_key"]
    _md5 = md5.update "#{ts}#{pvt_key}#{pub_key}"
    _md5.hexdigest
  end

  def self.characters()
    timestamp = Time.now
    api_hash = set_md5(timestamp)
    api_config = MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]
    api_key = api_config["public_key"]
    base_url = api_config["base_url"]
    endpoint = api_config["endpoint"]
    url = "#{base_url}/#{endpoint}/characters"
    response = Faraday.get(url, {apikey: api_key, ts: timestamp, hash: api_hash})
    JSON.parse(response.body, symbolize_names: true)
  end
end
