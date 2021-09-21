require 'rails_helper'

RSpec.describe MarvelController, type: :controller do
  describe "GET /" do
    before do
      get 'show'
    end

    let(:json_response) { JSON.parse(response.body) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns required information" do
      json_result = json_response["data"]["results"][0]
      expect(json_response).to have_key("attributionText")
      expect(json_result).to have_key("description")
      expect(json_result).to have_key("name")
    end
  end
end
