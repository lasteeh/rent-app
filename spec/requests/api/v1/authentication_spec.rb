require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :request do
  let!(:landlord) { FactoryBot.create(:landlord) }
  let(:valid_signin_params) do
    { email: landlord.email, password: landlord.password }
  end
  let(:invalid_signin_params) do
    { email: landlord.email, password: 'wrong_password' }
  end

  describe 'POST /api/v1/auth/landlord' do
    context 'with valid credentials' do
      before { post '/api/v1/auth/landlord', params: valid_signin_params }

      it 'returns an authentication token' do
        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response)
        expect(parsed_response['landlord']['email']).to eq(landlord.email)
        expect(parsed_response['authentication_token']).to_not be_empty
        expect(parsed_response['authentication_token']).to_not be_nil
      end
    end

    context 'with invalid credentials' do
      before { post '/api/v1/auth/landlord', params: invalid_signin_params }

      it 'returns an error message' do
        expect(response).to have_http_status(:unauthorized)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to eq(['Invalid email or password'])
      end
    end
  end
end
