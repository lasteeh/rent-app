class Rental < ApplicationRecord
  # associations
  belongs_to :property
  belongs_to :renter

  # validations
  validates :start_date, presence: true, date_format: true
  validate :start_date_cannot_be_in_the_past
  validates :duration_months,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
            }

  validates :renter_id, presence: true
  validates :property_id, presence: true

  def self.make(rental_params)
    rental = new(rental_params)

    if rental.save
      return rental, nil
    else
      error_messages = rental.errors.full_messages
      return rental, error_messages
    end
  end

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.zone.today
      errors.add(:start_date, "can't be in the past")
    end
  end
end
