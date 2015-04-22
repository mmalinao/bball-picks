FactoryGirl.define do
  factory :team do
    id { SecureRandom.uuid }
    name 'Raptors'
    market 'Toronto'
    alias_name 'TOR'
  end
end
