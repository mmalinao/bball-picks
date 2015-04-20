FactoryGirl.define do
  factory :series do
    id { SecureRandom.uuid }
    title 'Game 1'
    status 'inprogress'
    start_date { Faker::Date.forward(7) }
    round 1
  end
end
