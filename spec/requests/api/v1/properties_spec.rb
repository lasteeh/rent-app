require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :request do
  let(:landlord) { FactoryBot.create(:landlord) }
  let(:property) { FactoryBot.create(:property) }

  describe 'POST /api/v1/properties' do
    let(:valid_attributes) do
      {
        address: property.address,
        city: property.city,
        province: property.province,
        zip_code: property.zip_code,
        landlord_id: property.landlord_id,
      }
    end

    let(:invalid_attributes) do
      {
        address: property.address,
        city: property.city,
        province: property.province,
        zip_code: property.zip_code,
      }
    end

    context 'when the request is valid' do
      before do
        post '/api/v1/properties',
             params: {
               property: valid_attributes,
             },
             headers: {
               Authorization: "Bearer #{landlord.token}",
             }
      end

      it 'creates a new property with valid attributes' do
        expect(response).to have_http_status(:created)
        expect(Property.count).to eq(2)
      end
    end
  end
end
