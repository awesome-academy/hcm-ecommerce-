FactoryBot.define do
  factory :product do
    name {"Samsung Galaxy S21"}
    quatity {50}
    association :category
    price {17_990_000}
    description {"empty"}
  end
end
