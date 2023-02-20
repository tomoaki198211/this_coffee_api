FactoryBot.define do
  factory :user do
    name { 'user_test1' }
    email { 'user_test@sample.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end

  factory :other_user, class: User do
    name { 'user_test2' }
    email { 'user_test2@sample.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end
end
