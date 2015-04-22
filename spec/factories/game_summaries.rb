FactoryGirl.define do
  factory :game_summary do
    id { SecureRandom.uuid }
    title 'Game 1'
    status 'closed'
    coverage 'full'
    scheduled { Faker::Time.forward(7, :evening) }
    clock '00:00'
    quarter 4
  end
end
