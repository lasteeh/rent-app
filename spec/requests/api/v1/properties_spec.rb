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

    context 'when the request is invalid' do
      before do
        post '/api/v1/properties',
             params: {
               property: invalid_attributes,
             },
             headers: {
               Authorization: "Bearer #{landlord.token}",
             }
      end

      it 'creates a new property with valid attributes' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Property.count).to eq(1)
      end
    end

    context 'as renter' do
      before do
        post '/api/v1/properties',
             params: {
               property: valid_attributes,
             },
             headers: {
               Authorization: "Bearer #{renter.token}",
             }
      end

      it 'denies permission to create' do
        expect(response).to have_http_status(:forbidden)
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
      let(:expected_properties) { landlord_2.properties }

      before do
        post '/api/v1/auth/landlord',
             params: {
               authentication: {
                 email: landlord_2.email,
                 password: 'a1b2c3DDDD!',
               },
             }

        parsed_response_before_action = JSON.parse(response.body)

        auth_token = parsed_response_before_action['landlord']['token']

        get '/api/v1/properties',
            headers: {
              Authorization: "Bearer #{auth_token}", # authenticate request to get past authentice_request method
            }
      end
      it 'returns all properties owned by landlord' do
        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['properties'].length).to eq(
          expected_properties.length,
        )
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
        expect(parsed_response['properties'].length).to eq(
          expected_properties.length,
        )
      end
    end
  end

  describe 'GET /api/v1/properties/:id' do
    let!(:property1) { FactoryBot.create(:property, landlord_id: landlord.id) }

    context 'when request is valid' do
      before do
        get "/api/v1/properties/#{property1.id}",
            headers: {
              Authorization: "Bearer #{landlord.token}",
            }
      end

      it 'returns the property details' do
        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['property']['id']).to eq(property1.id)
      end
    end

    context 'when id is not valid' do
      before do
        get '/api/v1/properties/9999999',
            headers: {
              Authorization: "Bearer #{landlord.token}",
            }
      end

      it 'returns a not found error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PATCH /api/v1/properties/:id' do
    let!(:property1) { FactoryBot.create(:property, landlord_id: landlord.id) }

    context 'when the request is valid' do
      let(:valid_attributes) do
        {
          address: 'new address',
          city: 'new city',
          province: 'new province',
          zip_code: 'new zip code',
        }
      end

      before do
        patch "/api/v1/properties/#{property1.id}",
              params: {
                property: valid_attributes,
              },
              headers: {
                Authorization: "Bearer #{landlord.token}",
              }
      end

      it 'updates the property with valid attributes' do
        expect(response).to have_http_status(:ok)
        updated_property = Property.find(property1.id)
        expect(updated_property.address).to eq(valid_attributes[:address])
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { landlord_id: nil } }

      before do
        patch "/api/v1/properties/#{property1.id}",
              params: {
                property: invalid_attributes,
              },
              headers: {
                Authorization: "Bearer #{landlord.token}",
              }
      end

      it 'does not update the property with invalid attributes' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'as not the landlord of the property' do
      let!(:landlord2) { FactoryBot.create(:landlord) }
      let(:valid_attributes) do
        {
          address: 'new address',
          city: 'new city',
          province: 'new province',
          zip_code: 'new zip code',
        }
      end

      before do
        patch "/api/v1/properties/#{property1.id}",
              params: {
                property: valid_attributes,
              },
              headers: {
                Authorization: "Bearer #{landlord2.token}",
              }
      end

      it 'denies permission to edit property details' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE /api/v1/properties/:id' do
    let!(:property1) { FactoryBot.create(:property, landlord_id: landlord.id) }

    context 'when request is valid' do
      before do
        delete "/api/v1/properties/#{property1.id}",
               headers: {
                 Authorization: "Bearer #{landlord.token}",
               }
      end

      it 'deletes the property' do
        expect(response).to have_http_status(:no_content)
        expect { Property.find(property1.id) }.to raise_error(
          ActiveRecord::RecordNotFound,
        )
      end
    end

    context 'as not the landlord of the property' do
      let!(:landlord2) { FactoryBot.create(:landlord) }

      before do
        delete "/api/v1/properties/#{property1.id}",
               headers: {
                 Authorization: "Bearer #{landlord2.token}",
               }
      end

      it 'denies permission to edit property details' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
