module MarvelApi
  class Characters
    def initialize
      @character_id = 1009368
      @timestamp = Time.now
    end

    def iron_man
      cfg = marvel_configs
      endpoint = cfg[:url]
      payload = {
        apikey: cfg[:key], ts: @timestamp, hash: cfg[:hash]
      }
      process_request(endpoint, payload)
    end

    def series(character_id)
      cfg = marvel_configs
      endpoint = "#{cfg[:url]}/series"
      payload = {
        apikey: cfg[:key], ts: @timestamp, hash: cfg[:hash], orderBy: "title", limit: 60
      }
      response = process_request(endpoint, payload)
      process_response(response)
    end

    # test version
    def iron_man_series
      cfg = marvel_configs
      process_request("#{cfg[:url]}/series", {
        apikey: cfg[:key], ts: @timestamp, hash: cfg[:hash], orderBy: "title"
      })
    end

    private

    def process_request(endpoint, payload)
      response = Faraday.get(endpoint, payload)

      if response.status == 200
        JSON.parse(response.body, symbolize_names: true)
      else
        render_error(response.status, "API Request Failed")
      end
    end

    def process_response(response)
      if response[:code] == 200
        response_data = response[:data]

        if response_data[:count] > 1
          render_results(response_data[:results])
        else
          render_error(409, "not enough results")
        end
      else
        render_error(response[:code], response[:status])
      end
    end

    def render_error(code, message)
      {error_code: code, error_message: message}
    end

    def filter_results(results)
      results.reject! {|result| result[:stories][:available] < 10}
    end

    def render_results(data)
      results = filter_results(data)
      render_response(results)
    end

    def render_response(results)
      results.map do |series|
        {
          title: series[:title],
          description: series[:description],
          thumbnail: series[:thumbnail]
        }
      end
    end

    protected

    def marvel_configs
      configs = marvel_credentials
      {
        :key => configs["public_key"],
        :hash => marvel_auth(configs),
        :url => marvel_url(configs)
      }
    end

    def marvel_credentials
      MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]
    end

    def marvel_url(configs)
      "#{configs["url"]}/characters/#{@character_id}"
    end

    def marvel_auth(configs)
      md5 = Digest::MD5.new
      pub_key = configs["public_key"]
      pvt_key = configs["private_key"]
      md5_hash = md5.update "#{@timestamp}#{pvt_key}#{pub_key}"
      md5_hash.hexdigest
    end
  end
end
