FactoryGirl.define do
  factory :game do
    id { SecureRandom.uuid }
    title 'Game 1'
    status 'scheduled'
    coverage 'full'
    scheduled { Faker::Time.forward(7, :evening) }
  end

  trait :closed do
    status 'closed'
    scheduled { Faker::Time.backward(7, :evening) }
  end

  trait :inprogress do
    status 'inprogress'
    scheduled { DateTime.now }
  end

  trait :scheduled do
    status 'scheduled'
    scheduled { Faker::Time.forward(7, :evening) }
  end
end
