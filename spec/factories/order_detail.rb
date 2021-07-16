FactoryBot.define do
  factory :order_detail do
    order {FactoryBot.create :order}
    product {FactoryBot.create :product}
    quatity {2}
    price {100_000}
  end
end
