FactoryBot.define do
  factory :order_detail do
    association :order
    association :product
    quatity {2}
    price {100_000}
  end
end
