class MarvelController < ApplicationController
  before_action :load_marvel_characters

  def show
    character = @marvel_characters.iron_man
    marvel_series = @marvel_characters.iron_man_series
    @series = CharacterPromoter.new(marvel_series).as_series
    marvel = CharacterPromoter.new(character).as_marvel
    hero = CharacterPromoter.new(character).as_hero
    @image = {
      "landscape" => hero[:image_landscape],
      "standard" => hero[:image_standard],
      "portrait" => hero[:image_portrait]
    }
    @attribute = marvel[:attribute]
    @description = hero[:description]
    @image_filename = hero[:image]
    @name = hero[:name]
  end

  private
    def load_marvel_characters
      @marvel_characters = MarvelApi::Characters.new
    end
end
