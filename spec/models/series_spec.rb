require 'rails_helper'

RSpec.describe Series, type: :model do
  it { is_expected.to have_many :games }

  it { is_expected.to validate_presence_of :id }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :round }
  it { is_expected.to validate_uniqueness_of :id }

  describe '.refresh' do
    subject(:do_action) { Series.refresh }

    let(:data) { load_fixture 'series' }
    let(:new_series) { Series.last }
    let(:new_game) { Game.last }
    before(:each) { allow(SportRadarApi).to receive(:schedules).and_return(data) }

    it 'should create a new series' do
      expect { do_action }.to change { Series.count }.by(1)
    end

    it 'should create a new game' do
      expect { do_action }.to change { Game.count }.by(1)
    end

    it 'should create a new associated game' do
      do_action
      expect(new_series.games).to include new_game
    end

    context 'when series already exists' do
      let!(:series) { FactoryGirl.create(:series, id: '00feb95c-9af2-45bc-83a8-cf44e85b3ce3') }

      it 'should not create a new series' do
        expect { do_action }.to_not change { Series.count }
      end

      it 'should update series attributes' do
        expect { do_action }.to change { series.reload.attributes }
      end
    end

    context 'when game already exists' do
      let!(:game) { FactoryGirl.create(:game, id: '67b9b8b9-2889-4e18-abb1-0610f53ef187') }

      it 'should not create a new game' do
        expect { do_action }.to_not change { Game.count }
      end

      it 'should update game attributes' do
        expect { do_action }.to change { game.reload.attributes }
      end
    end
  end
end
