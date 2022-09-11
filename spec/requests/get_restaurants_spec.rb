require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:restaurant, 5)
      get '/api/v1/restaurants'
    end
    
    it 'returns all posts' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body.count).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end