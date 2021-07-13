FactoryBot.define do
  factory :evaluate do
    association :user
    association :product
    content {"content data"}
    star {3}
  end
end
