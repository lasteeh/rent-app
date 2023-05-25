FactoryBot.define do
  factory :rental do
    start_date { Faker::Date.forward }
    duration_months { Faker::Number.within(range: 1..10) }
    renter
    property
  end
end
