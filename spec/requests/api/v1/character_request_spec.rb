require 'rails_helper'

RSpec.describe 'Characters API', type: :request do
  describe 'GET /v1/public/characters/:characterId' do
    let(:character) { MarvelApi::Characters.new.iron_man }
    before { get '/api/v1/show' }

    it 'returns a valid response' do
      expect(json).not_to be_empty
      expect(response).to have_http_status(200)
    end

    it 'returns required character details' do
      expect(json["name"]).to eq(character[:data][:results][0][:name])
      expect(json["description"]).to eq(character[:data][:results][0][:description])
    end
  end
end
