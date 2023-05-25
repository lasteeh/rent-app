require 'rails_helper'

RSpec.describe Api::V1::RentalsController, type: :request do
  let!(:landlord) { FactoryBot.create(:landlord) }
  let!(:property1) { FactoryBot.create(:property) }
  let!(:property2) { FactoryBot.create(:property) }
  let!(:renter) { FactoryBot.create(:renter) }

  describe 'POST /api/v1/rental' do
    let(:valid_attributes) do
      {
        property_id: property1.id,
        renter_id: renter.id,
        start_date: 'nov 5 2025',
        duration_months: 5,
      }
    end
    let(:invalid_attributes) do
      {
        property_id: property1.id,
        renter_id: renter.id,
        start_date: 'may 30',
        duration_months: '-99',
      }
    end

    context 'wen the request is valid' do
      before do
        post '/api/v1/rentals',
             params: {
               rental: valid_attributes,
             },
             headers: {
               Authorization: "Bearer #{renter.token}",
             }
      end

      it 'creates a new rental with valid attributes' do
        p parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
      end
    end

    context 'wen the request is invalid' do
      before do
        post '/api/v1/rentals',
             params: {
               rental: invalid_attributes,
             },
             headers: {
               Authorization: "Bearer #{renter.token}",
             }
      end

      it 'creates a new rental with valid attributes' do
        p parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
