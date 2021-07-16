FactoryBot.define do
  factory :evaluate do
    user {FactoryBot.create :user}
    product {FactoryBot.create :product}
    content {"content data"}
    star {3}
  end
end
