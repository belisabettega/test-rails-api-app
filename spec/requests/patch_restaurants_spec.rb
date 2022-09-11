require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  describe 'PATCH /update' do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant, name: "Restaurant Test show", user: user) }

    before do       
        patch "/api/v1/restaurants/#{restaurant.id}",
            params: { "restaurant": { "name": "New Restaurant Test name" } },
            headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token}
    end

    it 'returns the restaurant with updated info' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["name"]).to eq("New Restaurant Test name")
        expect(restaurant.reload.name).to eq("New Restaurant Test name")
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(:success)
    end
  end
end