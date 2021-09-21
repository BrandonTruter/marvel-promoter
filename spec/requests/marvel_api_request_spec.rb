require 'rails_helper'
require 'marvel_api_client'

RSpec.describe "MarvelApiClient", type: :request do
  describe 'characters endpoint' do
    let(:characters) { MarvelApiClient.list_characters() }

    context "GET /v1/public/characters" do
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

  describe 'character endpoint' do
    let(:character) { MarvelApiClient.fetch_character(1009368) }

    context "GET /v1/public/characters/:characterId" do
      it "returns a successful response" do
        expect(character[:code]).to eq(200)
        expect(character).to be_kind_of(Hash)
      end

      it "returns the attributionText" do
        expect(character).to have_key(:attributionText)
      end

      it "returns required details" do
        expect(character[:data][:results][0]).to have_key(:name)
        expect(character[:data][:results][0]).to have_key(:description)
      end
    end
  end

end
