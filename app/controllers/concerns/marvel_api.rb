module MarvelApi
  class Characters
    def initialize
      @timestamp = Time.now
      @character_id = 1009368
    end

    def iron_man
      response = api_request(:character)
      return nil if response.status != 200
      JSON.parse(response.body, symbolize_names: true)
    end

    def iron_man_series
      response = api_request(:series)
      return nil if response.status != 200
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def api_request(entity)
      cfg = load_marvel_configs
      prefix = "series" unless entity == :character
      endpoint = prefix.nil? ? cfg[:url] : "#{cfg[:url]}/#{prefix}"
      Faraday.get(
        endpoint, {
          apikey: cfg[:key],
          hash: cfg[:hash],
          ts: @timestamp
        }
      )
    end

    protected

    def load_marvel_configs
      md5 = Digest::MD5.new
      api_config = MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]
      character_url = "#{api_config["url"]}/characters/#{@character_id}"
      pvt_key = api_config["private_key"]
      pub_key = api_config["public_key"]
      _md5 = md5.update "#{@timestamp}#{pvt_key}#{pub_key}"
      md5_hash = _md5.hexdigest
      {
        :key => pub_key,
        :hash => md5_hash,
        :url => character_url
      }
    end
  end
end
