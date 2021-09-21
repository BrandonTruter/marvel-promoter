require 'rails_helper'
require 'marvel_api_client'

RSpec.describe "MarvelApiClient", type: :request do
  describe 'GET /v1/public/characters' do
    let(:characters) { MarvelApiClient.characters() }

    it "returns a successful response" do
      expect(characters[:code]).to eq(200)
      expect(characters[:status]).to eq("Ok")
    end

    it "returns the attributionText" do
      expect(characters).to have_key(:attributionText)
    end

    it "returns a character id" do
      expect(characters).to be_kind_of(Hash)
      expect(characters[:data][:results][0]).to have_key(:id)
    end
  end
end
