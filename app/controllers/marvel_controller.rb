class MarvelController < ApplicationController
  before_action :find_character

  def show
    iron_man = @marvel_characters.iron_man
    @character = CharacterPromoter.new(iron_man).as_hero
    @series = @marvel_characters.series(iron_man[:id])
  end

  private
    def find_character
      @marvel_characters = MarvelApi::Characters.new
    end
end
