class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_landlord, :current_renter

  private

  def authenticate_request
    p 'AUTHENTICATINGGGGG'
    token = request.headers['Authorization']&.split(' ')&.last
    if token.nil?
      return render json: { errors: ['Token is empty'] }, status: :unauthorized
    end

    p "#{token} token received from post request in headers"

    @current_landlord = Landlord.find_by(token: token)
    @current_renter = Renter.find_by(token: token)

    if @current_landlord.nil? && @current_renter.nil?
      p 'user not found'
      return render json: { errors: ['Invalid Token'] }, status: :unauthorized
    end
    p 'user found in authenticate request method'
    p "#{@current_landlord.email} user email"
    p "#{@current_landlord.id} user id"
    p "#{@current_landlord.token} user token"
  end
end
