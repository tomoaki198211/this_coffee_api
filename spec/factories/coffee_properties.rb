FactoryBot.define do
  factory :coffee_property do
    name { '何か' }
    size {'S'}
    price {200}
    association :store
  end
end
