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

  describe '.refresh' do
    subject(:do_action) { GameSummary.refresh(game_id) }

    let(:game_id) { 'foo' }
    let(:data) { load_fixture 'game_summary' }
    before(:each) { allow(SportRadarApi).to receive(:game_summary).with(game_id).and_return(data) }

    it 'should create a new game summary' do
      expect { do_action }.to change { GameSummary.count }.by(1)
    end

    context 'when game summary already exists' do
      let!(:game_summary) { FactoryGirl.create(:game_summary, id: '67b9b8b9-2889-4e18-abb1-0610f53ef187') }

      it 'should not create a new game summary' do
        expect { do_action }.to_not change { GameSummary.count }
      end

      it 'should update game summary attributes' do
        expect { do_action }.to change { game_summary.reload.attributes }
      end
    end
  end
end
