FactoryGirl.define do
  factory :game do
    id { SecureRandom.uuid }
    title 'Game 1'
    status 'inprogress'
    coverage 'full'
    scheduled { Faker::Time.forward(7, :evening) }
  end
end
