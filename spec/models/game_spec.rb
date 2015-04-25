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

  describe '#display_title' do
    subject { game.display_title }

    let(:game) { FactoryGirl.create(:game, home_team: home_team, away_team: away_team) }
    let(:home_team) { FactoryGirl.create(:team) }
    let(:away_team) { FactoryGirl.create(:team) }

    it 'should display Away Team @ Home Team - Game #' do
      is_expected.to eq "#{away_team.alias_name} @ #{home_team.alias_name} - #{game.title}"
    end
  end

  describe '#refresh_stats' do
    subject(:do_action) { game.refresh_stats }

    let(:data) { load_fixture 'game_summary' }
    let(:game) { FactoryGirl.create(:game, id: '67b9b8b9-2889-4e18-abb1-0610f53ef187') }

    before(:each) { allow(SportRadarApi).to receive(:game_summary).with(game.id).and_return(data) }

    it 'should update game attributes' do
      expect { do_action }.to change { game.reload.attributes }
    end

    it 'should create a new game summary' do
      expect { do_action }.to change { GameSummary.count }.by(1)
    end

    context 'when game summary already exists' do
      let!(:game_summary) { FactoryGirl.create(:game_summary, id: game.id) }

      it 'should not create a new game summary' do
        expect { do_action }.to_not change { GameSummary.count }
      end

      it 'should update existing game summary attributes' do
        expect { do_action }.to change { game_summary.reload.attributes }
      end
    end
  end

  describe '#closed?' do
    subject { game.closed? }
    let(:game) { FactoryGirl.create(:game, :closed) }

    it { is_expected.to be_truthy }

    context 'when game inprogress' do
      let(:game) { FactoryGirl.create(:game, :inprogress) }
      it { is_expected.to be_falsey }
    end

    context 'when game scheduled' do
      let(:game) { FactoryGirl.create(:game, :scheduled) }
      it { is_expected.to be_falsey }
    end
  end

  describe '#inprogress?' do
    subject { game.inprogress? }
    let(:game) { FactoryGirl.create(:game, :inprogress) }

    it { is_expected.to be_truthy }

    context 'when game closed' do
      let(:game) { FactoryGirl.create(:game, :closed) }
      it { is_expected.to be_falsey }
    end

    context 'when game scheduled' do
      let(:game) { FactoryGirl.create(:game, :scheduled) }
      it { is_expected.to be_falsey }
    end
  end

  describe '#scheduled?' do
    subject { game.scheduled? }
    let(:game) { FactoryGirl.create(:game, :scheduled) }

    it { is_expected.to be_truthy }

    context 'when game closed' do
      let(:game) { FactoryGirl.create(:game, :closed) }
      it { is_expected.to be_falsey }
    end

    context 'when game inprogress' do
      let(:game) { FactoryGirl.create(:game, :inprogress) }
      it { is_expected.to be_falsey }
    end
  end
end
