class MarvelController < ApplicationController
  before_action :load_marvel_characters

  def show
    character = @marvel_characters.iron_man
    hero = CharacterPromoter.new(character).as_hero
    marvel = CharacterPromoter.new(character).as_marvel

    etag = marvel[:etag]
    copyright = marvel[:copyright]
    @attribute = marvel[:attribute]
    @description = hero[:description]
    @image_filename = hero[:image]
    @name = hero[:name]

    response = character[:data]
    resp_limit = response[:limit]
    iron_man = response[:results][0]
    # thumbnail = iron_man[:thumbnail]
    # @name = iron_man[:name]
    # @description = iron_man[:description]
    # @image_filename = "#{thumbnail[:path]}.#{thumbnail[:extension]}"
    # @attribute = character[:attributionText]
    # uri = iron_man[:resourceURI]
    series = iron_man[:series]
    series_returned = series[:returned]
    series_available = series[:available]
    series_items = series[:items]
    first_series_name = series_items[0][:name]
    stories = iron_man[:stories]
    stories_returned = stories[:returned]
    stories_available = stories[:available]
    # series_collection_uri = series[:collectionURI]
    logger.info "MARVEL :: copyright: #{copyright}, etag: #{etag}, limit: #{resp_limit}"
    logger.info "IronMan SERIES :: Returned: #{series_returned}, Available: #{series_available}, First Series Name: #{first_series_name}"
    logger.info "IronMan STORIES :: Returned: #{stories_returned}, Available: #{stories_available}"
    # comics = iron_man[:comics]
    # events = iron_man[:events]
    # links = iron_man[:urls]
  end

  private
    def load_marvel_characters
      @marvel_characters = MarvelApi::Characters.new
    end
end
