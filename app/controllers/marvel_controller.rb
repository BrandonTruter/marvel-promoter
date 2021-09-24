class MarvelController < ApplicationController
  before_action :load_marvel_characters

  def show
    character = @marvel_characters.iron_man
    marvel_series = @marvel_characters.iron_man_series
    @series = CharacterPromoter.new(marvel_series).as_series
    marvel = CharacterPromoter.new(character).as_marvel
    hero = CharacterPromoter.new(character).as_hero
    @attribute = marvel[:attribute]
    @description = hero[:description]
    @image_filename = hero[:image]
    @name = hero[:name]
    images = hero[:images]
    @image = thumbnail_helper(images)
    # @image = {
    #   "landscape" => hero[:image_landscape],
    #   "standard" => hero[:image_standard],
    #   "portrait" => hero[:image_portrait]
    # }
  end

  def thumbnail_helper(images)
    standard_images = images[:standard]
    portrait_images = images[:portrait]
    landscape_images = images[:landscape]
    {
      "standard" => {
        "small" => standard_images[:small],
        "medium" => standard_images[:medium],
        "large" => standard_images[:large],
        "amazing" => standard_images[:amazing],
        "fantastic" => standard_images[:fantastic]
      },
      "portrait" => {
        "small" => portrait_images[:small],
        "medium" => portrait_images[:medium],
        "large" => portrait_images[:large],
        "uncanny" => portrait_images[:uncanny],
        "amazing" => portrait_images[:amazing],
        "fantastic" => portrait_images[:fantastic]
      },
      "landscape" => {
        "small" => landscape_images[:small],
        "medium" => landscape_images[:medium],
        "large" => landscape_images[:large],
        "amazing" => landscape_images[:amazing],
        "incredible" => landscape_images[:incredible]
      }
    }
  end

  private
    def load_marvel_characters
      @marvel_characters = MarvelApi::Characters.new
    end
end
