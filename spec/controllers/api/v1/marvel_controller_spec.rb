require 'rails_helper'

RSpec.describe Api::V1::MarvelController do
  describe "GET /api/v1/show" do
    before do
      get :show
    end
    let(:json_response) { JSON.parse(response.body) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns character details" do
      expect(json_response).to have_key("description")
      expect(json_response).to have_key("name")
    end
  end
end
