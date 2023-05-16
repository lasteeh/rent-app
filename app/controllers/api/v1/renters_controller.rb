class Api::V1::RentersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def index; end

  def create
    # signup
    @renter, @error_messages = Renter.signup(signup_params)

    if @error_messages.nil?
      serialized_renter = RenterSerializer.serialize_user(@renter)
      render json: { renter: serialized_renter }, status: :created
    else
      render json: { errors: @error_messages }, status: :unprocessable_entity
    end
  end

  def show; end

  def update; end

  def destroy; end

  private

  def signup_params
    params
      .require(:renter)
      .permit(
        :first_name,
        :last_name,
        :email,
        :phone_number,
        :password,
        :password_confirmation,
      )
  end
end
