FactoryBot.define do
  factory :landlord do
    # Add appropriate attributes for the landlord model
    first_name { 'first name' }
    last_name { 'last name' }
    email { 'landlord1@email.com' }
    phone_number { '09454545454' }
  end
end
