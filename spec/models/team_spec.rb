require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to have_many(:home_games).class_name('Game').with_foreign_key('home_game_id') }
  it { is_expected.to have_many(:away_games).class_name('Game').with_foreign_key('away_game_id') }

  it { is_expected.to validate_presence_of :id }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :alias_name }
  it { is_expected.to validate_presence_of :market }
  it { is_expected.to validate_uniqueness_of :id }

  describe '.refresh' do
    subject(:do_action) { Team.refresh }

    let(:data) { load_fixture 'teams' }
    before(:each) { allow(SportRadarApi).to receive(:teams).and_return(data) }

    it 'should create a new team' do
      expect { do_action }.to change { Team.count }.by(1)
    end

    context 'when team already exists' do
      let!(:team) { FactoryGirl.create(:team, id: '583ec8d4-fb46-11e1-82cb-f4ce4684ea4c') }

      it 'should not create a new team' do
        expect { do_action }.to_not change { Team.count }
      end

      it 'should update team attributes' do
        expect { do_action }.to change { team.reload.attributes }
      end
    end
  end
end
