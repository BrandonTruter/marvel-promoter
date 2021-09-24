module Api::V1
  class MarvelController < ApplicationController
    before_action :fetch_characters

    def show
      render json: CharacterPromoter.new(@characters.iron_man).as_hero
    end

    def index
      render json: @characters.iron_man_series
    end

    private

    def fetch_characters
      @characters = MarvelApi::Characters.new
    end
  end
end
