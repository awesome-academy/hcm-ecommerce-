FactoryBot.define do
  factory :order do
    user {FactoryBot.create :user}
    status {1}
    fullname {Faker::Name.name}
    phone_number {Faker::PhoneNumber.phone_number}
    address {Faker::Address.full_address}
    after(:create) do |order|
      FactoryBot.create :order_detail, order: order
    end
  end
end
