FactoryBot.define do
  factory :product do
    name {Faker::Name.name}
    quatity {50}
    category {FactoryBot.create :category}
    price {17_990_000}
    description {"empty"}
  end
end
