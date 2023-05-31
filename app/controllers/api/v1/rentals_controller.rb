class Api::V1::RentalsController < ApplicationController
  before_action :set_rental, only: %i[show update destroy]

  def index
    if @current_landlord
      landlord_property_ids = current_landlord.properties.pluck(:id)
      rentals =
        Rental.joins(:property).where(properties: { id: landlord_property_ids })
    elsif @current_renter
      rentals = Rental.joins(:renter).where(renters: { id: @current_renter.id })
    elsif @current_renter.nil? && @current_landlord.nil?
      return(
        render json: { errors: ['Not a renter/landlord'] }, status: :forbidden
      )
    end

    serialized_rentals = RentalSerializer.serialize_rentals(rentals)
    render json: { rentals: serialized_rentals }, status: :ok
  end

  def create
    rental, error_messages = Rental.make(rental_params)

    if error_messages.nil?
      serialized_rental = RentalSerializer.serialize_rental(rental)
      render json: { rental: serialized_rental }, status: :created
    else
      render json: { errors: error_messages }, status: :unprocessable_entity
    end
  end

  def show
    serialized_rental = RentalSerializer.serialize_rental(@rental)
    render json: { rental: serialized_rental }, status: :ok
  end

  def update; end

  def destroy; end

  private

  def set_rental
    @rental = Rental.find_by(id: params[:id])

    if @rental.nil?
      render json: { errors: ['Rental not found'] }, status: :not_found
    end
  end

  def rental_params
    params
      .require(:rental)
      .permit(
        :property_id,
        :renter_id,
        :start_date,
        :duration_months,
        :rent_per_month,
      )
  end
end
