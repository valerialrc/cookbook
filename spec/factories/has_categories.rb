FactoryBot.define do
  factory :has_category do
    association :recipe
    association :category
  end
end
