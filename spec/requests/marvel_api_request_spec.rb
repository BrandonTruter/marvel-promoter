require 'rails_helper'
require 'marvel_api_client'

RSpec.describe "MarvelApiClient", type: :request do

  describe 'GET /v1/public/characters' do
    let(:characters_response) { MarvelApiClient.characters() }

    it "returns a successful response" do
      expect(characters_response.status).to eq(200)
    end

    it "returns a specific character id" do
      expect(characters_response).to be_kind_of(Hash)
      expect(characters_response).to have_key(:id)
    end
  end

end
