class Api::V1::AuthenticationController < ApplicationController
  def landlord_create
    # signin
    @landlord, @error_messages = Landlord.signin(signin_params)

    if @error_messages.nil?
      render json: {
               landlord: {
                 id: @landlord.id,
                 email: @landlord.email,
                 authentication_token: @landlord.token,
               },
             },
             status: :ok
    else
      render json: { error: @error_messages }, status: :unauthorized
    end
  end

  def destroy; end

  private

  def signin_params
    params.permit(:email, :password)
  end
end
