FactoryGirl.define do
  factory :player do
    id { SecureRandom.uuid }
    first_name 'LeBron'
    last_name 'James'
    position 'F'
    primary_position 'SF'
    jersey_number 23
  end
end
