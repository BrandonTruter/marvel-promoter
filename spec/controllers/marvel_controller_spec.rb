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
  end
end
