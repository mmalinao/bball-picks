require 'rails_helper'

RSpec.describe Series, type: :model do
  it { is_expected.to have_many :games }

  it { is_expected.to validate_presence_of :id }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :round }
  it { is_expected.to validate_uniqueness_of :id }
end
