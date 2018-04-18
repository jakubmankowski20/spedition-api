FactoryBot.define do 
  factory :user do 
    login 'testuser'
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email 'test@example.com'
    password 'password'
    phone_number '666666666'
  end
end