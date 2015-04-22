require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:picks).class_name('Player').with_foreign_key('fantasy_draft_manager_id') }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :user_name }
end
