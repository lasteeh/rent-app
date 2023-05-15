class Landlord < ApplicationRecord
  include UserRegistration # registration for user
  include UserAuthentication # authentication for user

  # associations
  has_many :properties, dependent: :destroy
end
