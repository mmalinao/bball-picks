FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    user_name { Faker::Internet.user_name }
  end
end
