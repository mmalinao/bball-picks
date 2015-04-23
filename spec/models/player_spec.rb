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

  describe '.pick' do
    subject(:do_action) { Player.pick(id, user) }

    let(:data) { load_fixture 'player' }
    let(:new_player) { Player.last }

    let(:id) { '18358040-89d8-4e25-a6a6-9e209c26fb3a' }
    let(:user) { FactoryGirl.create(:user) }

    before(:each) { allow(SportRadarApi).to receive(:player_profile).and_return(data) }

    it 'should create a new player' do
      expect { do_action }.to change { Player.count }.by(1)
    end

    it 'should assign fantasy draft manager' do
      do_action
      expect(new_player.fantasy_draft_manager).to eq user
    end

    context 'when player already exists' do
      let!(:player) { FactoryGirl.create(:player, id: '18358040-89d8-4e25-a6a6-9e209c26fb3a') }

      it 'should not create a new player' do
        expect { do_action }.to_not change { Player.count }
      end
    end
  end
end
