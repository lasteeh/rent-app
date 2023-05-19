class Api::V1::RentalsController < ApplicationController
  def index; end

  def create
    rental, error_messages = Rental.make(rental_params)

    if error_messages.nil?
      serialized_rental = RentalSerializer.serialize_rental(rental)
      render json: { rental: serialized_rental }, status: :created
    else
      render json: { errors: error_messages }, status: :unprocessable_entity
    end
  end

  def show; end

  def update; end

  def destroy; end

  private

  def rental_params
    params
      .require(:rental)
      .permit(:property_id, :renter_id, :start_date, :duration_months)
  end
end
