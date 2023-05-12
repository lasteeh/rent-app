class Api::V1::LandlordsController < ApplicationController
  def index; end

  def create
    # signup
    @landlord, @error_messages = Landlord.signup(signup_params)

    if @error_messages.nil?
      render json: @landlord, status: :created
    else
      render json: @error_messages, status: :unprocessable_entity
    end
  end
  def show; end

  def update; end

  def destroy; end

  private

  def signup_params
    params
      .require(:landlord)
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
