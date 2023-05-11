class Renter < ApplicationRecord
  include NormalizeAttributes # normalize first name, last name, and email address

  # validations
  validates :first_name,
            presence: true,
            length: {
              minimum: 1,
            },
            name_format: true
  validates :last_name,
            presence: true,
            length: {
              minimum: 1,
            },
            name_format: true
  validates :email,
            email_format: true,
            presence: true,
            uniqueness: {
              case_sensitive: false,
            }
  validates :phone_number, presence: true, uniqueness: { case_sensitive: false }
end
