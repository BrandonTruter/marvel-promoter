module Api::V1
  class MarvelController < ApplicationController
    before_action :find_characters

    def index
      render json: CharacterPromoter.new(@characters.iron_man_series).as_series
    end

    def show
      render json: CharacterPromoter.new(@characters.iron_man).as_hero
    end

    private

    def find_characters
      @characters = MarvelApi::Characters.new
    end
  end
end
