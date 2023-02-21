FactoryBot.define do
  factory :user do
    name { 'user_test1' }
    email { 'user_test@sample.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin {false}
  end

  factory :user2, class: User do
    name { 'user_test3' }
    email { 'user_test3@sample.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin {false}
  end

  factory :admin, class: User do
    name { 'user_test2' }
    email { 'admin_test@sample.com' }
    password { 'pass1234' }
    password_confirmation { 'pass1234' }
    admin {true}
  end
end
