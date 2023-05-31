FactoryBot.define do
  factory :property do
    # Add appropriate attributes for the property model
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    province { Faker::Address.state }
    zip_code { Faker::Address.zip_code }
    rent_per_month { 2000 }
    units { Faker::Number.within(range: 1..10) }
    landlord
  end
end
