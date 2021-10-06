class MarvelClient
  include Exceptions
  include StatusCodes
  attr_reader :api_key, :timestamp

  def initialize(api_key = nil)
    @api_key = api_key
    @timestamp = Time.now
  end

  def marvel_character(character_id)
    response = request(
      http_method: :get,
      endpoint: "#{credentials["url"]}/characters/#{character_id}"
    )
    process_request(response)
  end

  def marvel_series(character_id)
    response = request(
      http_method: :get,
      endpoint: "#{credentials["url"]}/characters/#{character_id}/series",
      headers: {orderBy: "title"}
    )
    series_response = process_request(response)
    process_response(series_response)
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
      client.params['apikey'] = api_key
      client.params['ts'] = timestamp
      client.params['limit'] = 40
    end
  end

  def request(http_method:, endpoint:, headers: {}, params: {})
    client.public_send(http_method, endpoint, headers, params)
  end

  def process_request(response)
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
    Digest::MD5.hexdigest "#{timestamp}#{credentials["private_key"]}#{api_key}"
  end

  def credentials
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
