require 'digest/md5'
require "faraday"
require "json"

class MarvelApiClient
  def self.marvel_configs
    MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]
  end
  def self.set_md5(ts)
    md5 = Digest::MD5.new
    pub_key = marvel_configs["public_key"]
    pvt_key = marvel_configs["private_key"]
    _md5 = md5.update "#{ts}#{pvt_key}#{pub_key}"
    _md5.hexdigest
  end
  def self.list_characters()
    ts = Time.now
    hash = set_md5(ts)
    cfg = marvel_configs
    url = "#{cfg["url"]}/characters"
    response = Faraday.get(
      url, {apikey: cfg["public_key"], ts: ts, hash: hash}
    )
    JSON.parse(response.body, symbolize_names: true)
  end
  def self.fetch_character(character_id)
    ts = Time.now
    hash = set_md5(ts)
    cfg = marvel_configs
    url = "#{cfg["url"]}/characters/#{character_id}"
    response = Faraday.get(
      url, {apikey: cfg["public_key"], ts: ts, hash: hash}
    )
    JSON.parse(response.body, symbolize_names: true)
  end
  def self.fetch_series(character_id)
    ts = Time.now
    hash = set_md5(ts)
    cfg = marvel_configs
    url = "#{cfg["url"]}/characters/#{character_id}/series"
    response = Faraday.get(
      url, {apikey: cfg["public_key"], ts: ts, hash: hash, orderBy: "title"}
    )
    JSON.parse(response.body, symbolize_names: true)
  end
end
