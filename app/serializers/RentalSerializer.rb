class RentalSerializer
  def self.serialize_rental(rental)
    {
      id: rental.id,
      renter_id: rental.renter_id,
      property_id: rental.property_id,
      start_date: rental.start_date,
      duration_months: rental.duration_months,
    }
  end

  def self.serialize_rentals(rentals)
    rentals.map { |rental| serialize_rental(rental) }
  end
end
