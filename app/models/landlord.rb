class Landlord < ApplicationRecord
  include UserRegistration # registration for user
  include UserAuthentication # authentication for user
end
