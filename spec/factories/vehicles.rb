FactoryBot.define do
  factory :vehicle do
    truck_brand { Faker::Vehicle.manufacture }
    registration_number { "EL" + Faker::Number.number(6) }
  end 
end