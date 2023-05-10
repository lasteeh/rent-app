class Landlord < ApplicationRecord
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

  # callbacks
  before_save :normalize_first_and_last_name
  before_save :normalize_email_address

  # custom methods

  # private methods
  private

  def normalize_first_and_last_name
    self.first_name = normalize_name(self.first_name)
    self.last_name = normalize_name(self.last_name)
  end

  def normalize_email_address
    self.email = email.downcase.strip
  end

  def normalize_name(name)
    name
      .split(/(\s|-)/)
      .map { |part| part.match?(/\s|-/) ? part : part.capitalize }
      .join
  end
end
