class MarvelClient
  include Exceptions
  include StatusCodes
  attr_reader :timestamp

  API_RESPONSE_LIMIT = 40
  API_ENDPOINT = 'https://gateway.marvel.com/v1/public'.freeze

  def initialize
    @timestamp = Time.now
  end

  def marvel_character(character_id)
    request(
      http_method: :get,
      endpoint: "#{API_ENDPOINT}/characters/#{character_id}"
    )
  end

  def marvel_series(character_id)
    response = request(
      http_method: :get,
      endpoint: "#{API_ENDPOINT}/characters/#{character_id}/series",
      headers: {'orderBy' => "title"}
    )
    process_response(response)
  end

  private

  def client
    @_client ||= Faraday.new() do |client|
      client.adapter Faraday.default_adapter
      # headers
      client.headers['Accept'] = "*/*"
      client.headers['Content-Type'] = "application/json"
      # params
      client.params['hash'] = gnereate_md5_hash()
      client.params['apikey'] = ENV["PUBLIC_KEY"]
      client.params['ts'] = timestamp
      client.params['limit'] = configs["limit"] || API_RESPONSE_LIMIT
    end
  end

  def request(http_method:, endpoint:, headers: {}, params: {})
    response = client.public_send(http_method, endpoint, headers, params)
    puts "RESPONSE HEADERS: #{response.headers}"

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    return parsed_response if response.status == HTTP_OK_CODE

    raise error_class, "Code: #{response.status}, response: #{response.body}"
  end

  def error_class
    case response.status
    when HTTP_BAD_REQUEST_CODE
      BadRequestError
    when HTTP_UNAUTHORIZED_CODE
      UnauthorizedError
    when HTTP_FORBIDDEN_CODE
      UnauthorizedError
    when HTTP_NOT_FOUND_CODE
      NotFoundError
    when API_NOT_ALLOWED_CODE
      UnprocessableEntityError
    when API_BAD_CREDENTIALS_CODE
      UnauthorizedError
    when API_REACHED_RATE_LIMIT
      ApiRequestsQuotaReachedError
    else
      ApiError
    end
  end

  def gnereate_md5_hash
    Digest::MD5.hexdigest "#{timestamp}#{ENV['PRIVATE_KEY']}#{ENV["PUBLIC_KEY"]}"
  end

  def configs
    MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]
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
      raise error_class, "Code: #{response.status}, response: #{response.body}"
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
end
