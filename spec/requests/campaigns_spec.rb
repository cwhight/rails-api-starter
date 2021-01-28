# spec/requests/campaigns_spec.rb
require 'rails_helper'

RSpec.describe 'Campaigns API', type: :request do
  # initialize test data
  let!(:campaigns) { create_list(:campaign, 10) }
  let(:campaign_id) { campaigns.first.id }

  # Test suite for GET /campaign
  describe 'GET /campaign' do
    # make HTTP get request before each example
    before { get '/campaign' }

    it 'returns campaign' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /campaign/:id
  describe 'GET /campaign/:id' do
    before { get "/campaign/#{campaign_id}" }

    context 'when the record exists' do
      it 'returns the campaign' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(campaign_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:campaign_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Campaign/)
      end
    end
  end

  # Test suite for POST /campaign
  describe 'POST /campaign' do
    first_name = 'name'
    last_name = 'surname'
    description = 'a description'
    bio = 'a bio'
    # valid payload
    let(:valid_attributes) { { first_name: first_name, last_name: last_name, description: description, bio: bio } }

    context 'when the request is valid' do
      before { post '/campaign', params: valid_attributes }

      it 'creates a campaign' do
        expect(json['first_name']).to eq(first_name)
        expect(json['last_name']).to eq(last_name)
        expect(json['description']).to eq(description)
        expect(json['bio']).to eq(bio)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/campaign', params: { first_name: first_name, last_name: last_name, description: description } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match("{\"message\":\"Validation failed: Bio can't be blank\"}")
      end
    end
  end

  # Test suite for PUT /campaign/:id
  describe 'PUT /campaign/:id' do
    let(:valid_attributes) { { first_name: 'New Name' } }

    context 'when the record exists' do
      before { put "/campaign/#{campaign_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /campaign/:id
  describe 'DELETE /campaign/:id' do
    before { delete "/campaign/#{campaign_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
