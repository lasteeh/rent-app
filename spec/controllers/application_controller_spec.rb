require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    before_action :authenticate_request

    def index
      # dummy index method
      render json: { message: 'authenticated' }, status: :ok
    end
  end

  let(:landlord) { FactoryBot.create(:landlord) }
  let(:renter) { FactoryBot.create(:renter) }

  describe '#authenticate_request' do
    context 'when a landlord is authenticated' do
      it 'allows access' do
        request.headers['Authorization'] = "Bearer #{landlord.token}"
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a renter is authenticated' do
      it 'allows access' do
        request.headers['Authorization'] = "Bearer #{renter.token}"
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when no user is authenticated' do
      it 'denies access' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
