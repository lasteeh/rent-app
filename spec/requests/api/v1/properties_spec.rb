require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :request do
  let(:landlord) { FactoryBot.create(:landlord) }
  let(:renter) { FactoryBot.create(:renter) }
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

  describe 'GET /api/v1/properties/' do
    context 'as landlord' do
      let!(:landlord_2) { FactoryBot.create(:landlord) }

      let!(:property1) do
        FactoryBot.create(:property, landlord_id: landlord.id)
      end
      let!(:property2) do
        FactoryBot.create(:property, landlord_id: landlord.id)
      end
      let!(:property3) do
        FactoryBot.create(:property, landlord_id: landlord_2.id)
      end
      let(:expected_properties) { landlord.properties }

      before do
        get '/api/v1/properties',
            headers: {
              Authorization: "Bearer #{landlord.token}", # authenticate request to get past authentice_request method
            }
      end
      it 'returns all properties owned by landlord' do
        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(expected_properties.length)
      end
    end

    context 'as renter' do
      let!(:landlord_2) { FactoryBot.create(:landlord) }

      let!(:property1) do
        FactoryBot.create(:property, landlord_id: landlord.id)
      end
      let!(:property2) do
        FactoryBot.create(:property, landlord_id: landlord.id)
      end
      let!(:property3) do
        FactoryBot.create(:property, landlord_id: landlord_2.id)
      end
      let!(:property4) { FactoryBot.create(:property) }
      let!(:property5) { FactoryBot.create(:property) }
      let(:expected_properties) { Property.all }

      before do
        get '/api/v1/properties',
            headers: {
              Authorization: "Bearer #{renter.token}", # authenticate request to get past authentice_request method
            }
      end
      it 'returns all properties' do
        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(expected_properties.length)
      end
    end
  end
end
