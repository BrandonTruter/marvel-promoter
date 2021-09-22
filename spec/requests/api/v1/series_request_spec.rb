require 'rails_helper'

RSpec.describe 'Series API', type: :request do
  describe 'GET /api/v1/index' do
    before { get '/api/v1/index' }

    context "GET /v1/public/characters/:characterId/series" do
      let(:series) { MarvelApi::Characters.new.iron_man_series }

      it 'response is valid' do
        expect(json).not_to be_empty
        expect(response).to have_http_status(200)
      end

      it "response ordered by title" do
        expect(series[:data][:results][0][:title]).to start_with 'A'
      end

      it "response contains 10 or more stories" do
        expect(json["story_count"]).to be >= 10
      end

      it "response includes the image and description" do
        expect(json["description"]).to eq(series[:data][:results][0][:description])
        expect(json["image"]).to include(series[:data][:results][0][:thumbnail][:path])
      end
    end
  end
end
