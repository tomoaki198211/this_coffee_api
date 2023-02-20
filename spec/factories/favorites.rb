FactoryBot.define do
  factory :favorite do
    association :user
    association :coffee
  end
end
