class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: :landlord_create

  def landlord_create
    # signin
    @landlord, @error_messages = Landlord.signin(signin_params)

    if @error_messages.nil?
      render json: {
               landlord: {
                 id: @landlord.id,
                 email: @landlord.email,
               },
               token: @landlord.generate_token,
             },
             status: :ok
    else
      render json: { errors: @error_messages }, status: :unauthorized
    end
  end

  private

  def signin_params
    params.permit(:email, :password)
  end
end
