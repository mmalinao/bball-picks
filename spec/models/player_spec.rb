require 'rails_helper'

RSpec.describe Player, type: :model do
  it { is_expected.to belong_to(:fantasy_draft_manager).class_name('User') }

  it { is_expected.to validate_presence_of :id }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :position }
  it { is_expected.to validate_presence_of :primary_position }
  it { is_expected.to validate_presence_of :jersey_number }
  it { is_expected.to validate_uniqueness_of :id }
end
