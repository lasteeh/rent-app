class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_landlord, :current_renter

  private

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    if token.nil?
      return render json: { error: ['Not Authorized'] }, status: :unauthorized
    end

    @current_landlord = Landlord.find_by(token: token)
    @current_renter = Renter.find_by(token: token)

    if @current_landlord.nil? && @current_renter.nil?
      render json: { error: ['Not Authorized'] }, status: :unauthorized
    end
  end
end
