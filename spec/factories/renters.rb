FactoryBot.define do
  factory :renter do
    # Add appropriate attributes for the landlord model
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name.gsub(/[^a-zA-Z\s-]/, '') }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    password { 'a1b2c3DDDD!' }
    password_confirmation { password }
  end
end
