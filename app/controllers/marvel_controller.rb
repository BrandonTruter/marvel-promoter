class MarvelController < ApplicationController
  before_action :initialize_client

  def show
    character_id = 1009368
    iron_man = @client.marvel_character(character_id)
    @character = CharacterPromoter.new(iron_man).as_hero
    @series = @client.marvel_series(character_id)

    fresh_when etag: @character[:etag], public: true
  end

  private

  def initialize_client
    @client = MarvelClient.new
  end
end
