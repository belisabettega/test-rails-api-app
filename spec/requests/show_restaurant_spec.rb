require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  describe 'GET /show' do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant, name: "Restaurant Test show", user: user) }
    let(:comment) { create(:comment, content: "Comment Test show", user: user, restaurant: restaurant) }

    before do
        FactoryBot.create_list(:restaurant, 5)
        comment
        get "/api/v1/restaurants/#{restaurant.reload.id}"
    end
    
    it 'returns the restaurant comments' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["name"]).to eq(restaurant.name)
        expect(parsed_body["comments"][0]["content"]).to eq(comment.content)
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(:success)
    end
  end
end