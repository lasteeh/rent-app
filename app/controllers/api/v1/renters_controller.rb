class Api::V1::RentersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def index; end

  def create
    # signup
    @renter, @error_messages = Renter.signup(signup_params)

    if @error_messages.nil?
      render json: {
               renter: {
                 id: @renter.id,
                 email: @renter.email,
                 authentication_token: @renter.token,
               },
             },
             status: :created
    else
      render json: { error: @error_messages }, status: :unprocessable_entity
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
