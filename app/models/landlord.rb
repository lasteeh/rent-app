class Landlord < ApplicationRecord
  include UserValidations # validates relative user fields
  include AttributeNormalizer # normalize first name, last name, and email address
  include UserRegistration # registers user
  include TokenGenerator # generates token
end
