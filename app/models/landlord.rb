class Landlord < ApplicationRecord
  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            email_format: true,
            presence: true,
            uniqueness: {
              case_sensitive: false,
            }
  validates :phone_number, presence: true, uniqueness: { case_sensitive: false }

  # callbacks
  before_save :normalize_email_address

  # custom methods

  # private methods
  private

  def normalize_email_address
    self.email = email.downcase
  end
end
