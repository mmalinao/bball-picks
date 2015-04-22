require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to validate_presence_of :id }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :alias_name }
  it { is_expected.to validate_presence_of :market }
  it { is_expected.to validate_uniqueness_of :id }
end
