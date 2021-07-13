FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {"123456"}
    password_confirmation {"123456"}
    fullname {Faker::Name.name}
    gender {Random.rand(2)}
    phone_number {Faker::PhoneNumber.phone_number}
    date_of_birth {Faker::Date.forward(days: 500)}
    address {Faker::Address.full_address}
  end
  
  factory :admin, class: User do
    email {Faker::Internet.email}
    password {"123456"}
    password_confirmation {"123456"}
    fullname {Faker::Name.name}
    gender {Random.rand(2)}
    phone_number {Faker::PhoneNumber.phone_number}
    date_of_birth {Faker::Date.forward(days: 500)}
    address {Faker::Address.full_address}
    role {1}
  end
end
