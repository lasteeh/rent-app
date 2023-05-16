class Api::V1::PropertiesController < ApplicationController
  before_action :set_property, only: %i[show update destroy]
  before_action :owner_only, only: %i[update destroy]

  def index
    if @current_landlord
      properties = @current_landlord.properties
    else
      properties = Property.all
    end

    serialized_properties = PropertySerializer.serialize_properties(properties)
    render json: { properties: serialized_properties }, status: :ok
  end

  def create
    # landlord only action

    if @current_landlord.nil? && !@current_renter.nil?
      return render json: { errors: ['Access denied'] }, status: :forbidden
    end

    # signup
    property, error_messages = Property.register(property_params)

    if error_messages.nil?
      serialized_property = PropertySerializer.serialize_property(property)
      render json: { property: serialized_property }, status: :created
    else
      render json: { errors: error_messages }, status: :unprocessable_entity
    end
  end

  def show
    serialized_property = PropertySerializer.serialize_property(@property)
    render json: { property: serialized_property }, status: :ok
  end

  def update
    property, error_messages =
      Property.edit_details(params[:id], property_params)

    if error_messages.nil?
      serialized_property = PropertySerializer.serialize_property(@property)
      render json: { property: serialized_property }, status: :ok
    else
      render json: { errors: error_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    render json: {
             message: 'Property deleted successfully',
           },
           status: :no_content
  end

  private

  def set_property
    @property = Property.find_by(id: params[:id])

    if @property.nil?
      render json: { errors: ['Property not found'] }, status: :not_found
    end
  end

  def property_params
    params
      .require(:property)
      .permit(
        :name,
        :description,
        :image_url,
        :address,
        :city,
        :province,
        :zip_code,
        :units,
        :landlord_id,
      )
  end

  def owner_only
    if @current_landlord.id != @property.landlord_id
      render json: { errors: ['Access denied'] }, status: :forbidden
    end
  end
end
