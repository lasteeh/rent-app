class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request,
                     only: %i[landlord_create renter_create]

  def landlord_create
    # signin
    @landlord, @error_messages = Landlord.signin(signin_params)

    if @error_messages.nil?
      serialized_token = TokenSerializer.serialize_user(@landlord)
      render json: { landlord: serialized_token }, status: :ok
    else
      render json: { errors: @error_messages }, status: :unauthorized
    end
  end

  def renter_create
    # signin
    @renter, @error_messages = Renter.signin(signin_params)

    if @error_messages.nil?
      serialized_token = TokenSerializer.serialize_user(@renter)
      render json: { renter: serialized_token }, status: :ok
    else
      render json: { errors: @error_messages }, status: :unauthorized
    end
  end

  private

  def signin_params
    params.require(:authentication).permit(:email, :password)
  end
end
