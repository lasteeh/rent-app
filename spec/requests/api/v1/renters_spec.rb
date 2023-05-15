require 'rails_helper'

RSpec.describe Api::V1::RentersController, type: :request do
  let(:renter) { FactoryBot.create(:renter) }

  describe 'POST /api/v1/renters/signup' do
    let(:valid_attributes) do
      {
        first_name: renter.first_name,
        last_name: renter.last_name,
        email: 'new_user@example.com',
        phone_number: '+12345678900',
        password: 'a1b2c3DDDD!',
        password_confirmation: 'a1b2c3DDDD!',
      }
    end

    let(:invalid_attributes) do
      {
        first_name: renter.first_name,
        last_name: renter.last_name,
        email: nil,
        phone_number: '+12345678900',
        password: 'a1b2c3DDDD!',
        password_confirmation: 'a1b2c3DDDD!',
      }
    end

    context 'when the request is valid' do
      before do
        post '/api/v1/renters/signup', params: { renter: valid_attributes }
      end

      it 'creates a new renter with valid attributes' do
        expect(response).to have_http_status(:created)
        expect(Renter.count).to eq(2)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['renter']['email']).to eq(
          valid_attributes[:email],
        )
        expect(parsed_response['renter']['email']).to_not be_empty
      end
    end

    context 'when request is invalid' do
      before do
        post '/api/v1/renters/signup', params: { renter: invalid_attributes }
      end

      it 'does not create a new renter with invalid attributes' do
        post '/api/v1/renters/signup', params: { renter: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to_not be_empty
      end
    end
  end
end
