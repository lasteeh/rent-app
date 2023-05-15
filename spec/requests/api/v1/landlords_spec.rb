require 'rails_helper'

RSpec.describe Api::V1::LandlordsController, type: :request do
  let(:landlord) { FactoryBot.create(:landlord) }

  describe 'POST /api/v1/landlords/signup' do
    let(:valid_attributes) do
      {
        first_name: landlord.first_name,
        last_name: landlord.last_name,
        email: 'new_user@example.com',
        phone_number: '+12345678900',
        password: 'a1b2c3DDDD!',
        password_confirmation: 'a1b2c3DDDD!',
      }
    end

    let(:invalid_attributes) do
      {
        first_name: landlord.first_name,
        last_name: landlord.last_name,
        email: nil,
        phone_number: '+12345678900',
        password: 'a1b2c3DDDD!',
        password_confirmation: 'a1b2c3DDDD!',
      }
    end

    context 'when the request is valid' do
      before do
        post '/api/v1/landlords/signup', params: { landlord: valid_attributes }
      end

      it 'creates a new landlord with valid attributes' do
        expect(response).to have_http_status(:created)
        expect(Landlord.count).to eq(2)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['landlord']['email']).to eq(
          valid_attributes[:email],
        )
      end
    end

    context 'when request is invalid' do
      before do
        post '/api/v1/landlords/signup',
             params: {
               landlord: invalid_attributes,
             }
      end

      it 'does not create a new landlord with invalid attributes' do
        post '/api/v1/landlords/signup',
             params: {
               landlord: invalid_attributes,
             }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to_not be_empty
      end
    end
  end
end
