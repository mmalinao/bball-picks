require 'rails_helper'

RSpec.describe GameSummary, type: :model do
  it { is_expected.to validate_presence_of :id }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to validate_presence_of :coverage }
  it { is_expected.to validate_presence_of :scheduled }
  it { is_expected.to validate_presence_of :clock }
  it { is_expected.to validate_presence_of :quarter }
  it { is_expected.to validate_uniqueness_of :id }
end
