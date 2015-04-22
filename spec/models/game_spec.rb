require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to belong_to :series }
  it { is_expected.to belong_to(:home_team).class_name('Team') }
  it { is_expected.to belong_to(:away_team).class_name('Team') }

  it { is_expected.to validate_presence_of :id }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to validate_presence_of :coverage }
  it { is_expected.to validate_presence_of :scheduled }
  it { is_expected.to validate_uniqueness_of :id }
end
