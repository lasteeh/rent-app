class Api::V1::PropertiesController < ApplicationController
  def index; end

  def create
    # signup
    @property, @error_messages = Property.register(property_params)

    if @error_messages.nil?
      render json: {
               property: {
                 name: @property.name,
                 description: @property.description,
                 id: @property.id,
                 address: @property.address,
                 city: @property.city,
                 province: @property.province,
                 zip_code: @property.zip_code,
                 units: @property.units,
               },
               image: {
                 url: @property.image_url,
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

  def property_params
    params
      .require(:property)
      .permit(:address, :city, :province, :zip_code, :landlord_id)
  end
end
