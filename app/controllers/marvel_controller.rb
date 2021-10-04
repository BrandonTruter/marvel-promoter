class MarvelController < ApplicationController
  def show
    @character = find_character
    @series = find_series
  end

  private

  def find_character
    call_gateway("characters/#{1009368}")
  end

  def find_series
    call_gateway("series/#{1009368}")
  end

  def call_gateway(action)
    configs = marvel_configs
    url = configs["gateway_url"]
    endpoint = "#{url}/#{action}"
    response = Faraday.get(
      endpoint, nil, {
        'apikey' => configs["public_key"]
      }
    )
    return nil if response.status != 200
    JSON.parse(response.body)["data"]
  end

  protected

  def marvel_configs
    MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]
  end

end
