FactoryBot.define do
  factory :review do
    intuition {1}
    efficiency {1}
    remarks {"まあまあ"}
    setting {true}
    association :user
  end
end
