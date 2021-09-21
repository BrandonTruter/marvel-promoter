module MarvelApi
  class Characters
    def initialize
      @timestamp = Time.now
      @character_id = 1009368
    end

    def iron_man
      cfg = load_marvel_configs
      key = cfg[:api_key]
      url = cfg[:api_url]
      md5 = cfg[:api_hash]
      response = Faraday.get(url, {apikey: key, ts: @timestamp, hash: md5})
      JSON.parse(response.body, symbolize_names: true)
    end

  protected

    def load_marvel_configs
      md5 = Digest::MD5.new
      api_config = MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]
      character_url = "#{api_config["base_url"]}/#{api_config["endpoint"]}/characters/#{@character_id}"
      pub_key = api_config["public_key"]
      pvt_key = api_config["private_key"]
      _md5 = md5.update "#{@timestamp}#{pvt_key}#{pub_key}"
      md5_hash = _md5.hexdigest
      {
        :api_key => pub_key,
        :api_hash => md5_hash,
        :api_url => character_url
      }
    end
  end
end
