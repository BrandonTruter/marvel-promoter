# require 'rails_helper'
# require 'marvel_api_client'
#
# RSpec.describe "MarvelApiClient" do
#   describe 'characters endpoint' do
#     let(:characters) { MarvelApiClient.list_characters() }
#
#     context "GET /v1/public/characters" do
#       it "returns a successful response" do
#         expect(characters[:code]).to eq(200)
#         expect(characters).to be_kind_of(Hash)
#       end
#
#       it "returns attributionText and character ids" do
#         expect(characters[:data][:results][0]).to have_key(:id)
#         expect(characters).to have_key(:attributionText)
#       end
#     end
#   end
#
#   describe 'character endpoint' do
#     let(:character) { MarvelApiClient.fetch_character(1009368) }
#
#     context "GET /v1/public/characters/:characterId" do
#       it "returns a successful response" do
#         expect(character[:code]).to eq(200)
#       end
#
#       it "returns the marvel attributionText" do
#         expect(character).to have_key(:attributionText)
#       end
#
#       it "returns the characters name and description" do
#         expect(character[:data][:results][0]).to have_key(:name)
#         expect(character[:data][:results][0]).to have_key(:description)
#       end
#     end
#   end
#
#   describe 'series endpoint' do
#     let(:series) { MarvelApiClient.fetch_series(1009368) }
#
#     context "GET /v1/public/characters/:characterId/series" do
#       it "returns a successful response" do
#         expect(series[:code]).to eq(200)
#       end
#
#       it "ordered by title" do
#         expect(series[:data][:results][0]["title"]).to start_with 'A'
#       end
#
#       it "includes more then 10 stories" do
#         story_count = series[:data][:results][0][:stories][:available]
#         expect(story_count).to > 9
#       end
#
#       it "includes series description and image" do
#         expect(series[:data][:results][0]).to have_key(:thumbnail)
#         expect(series[:data][:results][0]).to have_key(:description)
#       end
#     end
#   end
#
# end
