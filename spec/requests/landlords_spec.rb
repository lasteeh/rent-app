require 'rails_helper'

RSpec.describe 'Landlords', type: :request do
  let!(:landlord) { FactoryBot.create(:landlord) }

  describe 'POST /landlords/login' do
    it 'logs in the landlord and sets a session cookie' do
      post '/landlords/session',
           params: {
             email: landlord.email,
             password: landlord.password,
           }
      expect(response).to have_http_status(:success)
      expect(response.headers['Set-Cookie']).to include('session_id')
    end
  end

  describe 'DELETE /landlords/logout' do
    it 'logs out the landlord and removes the session cookie' do
      post '/landlords/logout',
           params: {
             email: landlord.email,
             password: landlord.password,
           }
      delete '/landlords/logout'
      expect(response).to have_http_status(:success)
      expect(response.headers['Set-Cookie']).to be_empty
    end
  end
end
