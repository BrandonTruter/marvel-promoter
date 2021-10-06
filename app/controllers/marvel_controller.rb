class MarvelController < ApplicationController
  before_action :select_character
  before_action :initialize_client

  def show
    iron_man = @client.marvel_character(@character_id)
    @character = CharacterPromoter.new(iron_man).as_hero
    @series = @client.marvel_series(@character_id)
  end

  private

  def select_character
    @character_id = 1009368
  end

  def initialize_client
    @client = MarvelClient.new(api_key)
    # @client = MarvelAPI::V2::Client.new(api_key)
  end

  def api_key
    MarvelPromoter::Application.config.MARVEL_CONFIG[Rails.env]["public_key"]
  end
end
