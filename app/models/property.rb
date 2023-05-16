class Property < ApplicationRecord
  # associations
  belongs_to :landlord

  # validations
  validates :address, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :zip_code, presence: true

  # registration
  def self.register(property_params)
    property = new(property_params)

    if property.save
      return property, nil
    else
      error_messages = property.errors.full_messages
      return property, error_messages
    end
  end

  # edit details

  def self.edit_details(id, property_params)
    property = find(id)

    if property.update(property_params)
      return property, nil
    else
      error_messages = property.errors.full_messages
      return property, error_messages
    end
  end
end
