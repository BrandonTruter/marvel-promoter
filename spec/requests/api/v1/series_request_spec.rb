require 'rails_helper'

RSpec.describe 'Series API', type: :request do
  describe 'GET /api/v1/index' do
    before { get '/api/v1/index' }

    context "GET /v1/public/characters/:characterId/series" do
      let(:series) { MarvelApi::Characters.new.iron_man_series }

      it 'valid response' do
        expect(json).not_to be_empty
        expect(response).to have_http_status(200)
      end

      it "ordered by title" do
        expect(series[:data][:results][0][:title]).to start_with 'A'
      end

      it "includes description" do
        expect(json["data"]["results"][0]["description"]).to eq(series[:data][:results][0][:description])
      end
    end
  end
end
