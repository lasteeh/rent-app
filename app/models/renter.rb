class Renter < ApplicationRecord
  include UserRegistration # registers user
  include UserAuthentication # authentication for user
end
