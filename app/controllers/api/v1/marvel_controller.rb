module Api::V1
  class MarvelController < ApplicationController
    before_action :find_character

    def show
      render json: @character.as_json
    end

    private

    def find_character
      marvel_characters = MarvelApi::Characters.new
      @character = marvel_characters.iron_man
    end
  end
end
