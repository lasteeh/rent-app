class PropertySerializer
  def self.serialize_property(property)
    {
      id: property.id,
      name: property.name,
      description: property.description,
      address: property.address,
      city: property.city,
      province: property.province,
      zip_code: property.zip_code,
      units: property.units,
      rent_per_month: property.rent_per_month,
      landlord_id: property.landlord_id,
      image_url: property.image_url,
    }
  end

  def self.serialize_properties(properties)
    properties.map { |property| serialize_property(property) }
  end
end
