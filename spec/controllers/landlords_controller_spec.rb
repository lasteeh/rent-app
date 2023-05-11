require 'rails_helper'

RSpec.describe Api::V1::LandlordsController, type: :controller do
  describe 'POST #signup' do
    let(:landlord) { FactoryBot.create(:landlord) }
    let(:landlord_attributes) { FactoryBot.attributes_for(:landlord) }

    it 'creates a new landlord with valid attributes' do
      post :signup, params: { landlord: landlord_attributes }
      expect(response).to have_http_status(:created)
      expect(response.body).to eq(JSON.generate(landlord.as_json))
    end

    it 'does not create a new landlord with invalid attributes' do
      landlord.email = nil
      post :signup, params: { landlord: landlord_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include(
        'first_name',
        'last_name',
        'email',
        'phone_number',
        'password',
      )
    end
  end
end
