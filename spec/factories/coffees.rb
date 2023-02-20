FactoryBot.define do
  factory :coffee do
    association :coffee_property
    association :category
  end
end
