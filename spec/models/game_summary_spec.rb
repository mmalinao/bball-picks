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
    subject(:do_action) { GameSummary.refresh(game.id) }

    let!(:game) { FactoryGirl.create(:game, id: '67b9b8b9-2889-4e18-abb1-0610f53ef187') }
    let(:data) { load_fixture 'game_summary' }
    let(:new_game_stats) { GameStats.last }

    before(:each) { allow(SportRadarApi).to receive(:game_summary).with(game.id).and_return(data) }

    it 'should create a new game summary' do
      expect { do_action }.to change { GameSummary.count }.by(1)
    end

    it 'should not create a new game' do
      expect { do_action }.to_not change { Game.count }
    end

    it 'should not create a new player' do
      expect { do_action }.to_not change { Player.count }
    end

    it 'should not create a new game stats' do
      expect { do_action }.to_not change { GameStats.count }
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

    context 'when home team player exists (fantasy draft pick)' do
      let!(:player) { FactoryGirl.create(:player, id: '0afbe608-940a-4d5d-a1f7-468718c67d91') }

      it 'should create a new game stats' do
        expect { do_action }.to change { GameStats.count }
        expect(new_game_stats.points).to eq 20
      end

      it 'should create a new game stats for game/player' do
        do_action
        expect(new_game_stats.game).to eq game
        expect(new_game_stats.player).to eq player
      end

      context 'when game stats already exists' do
        let!(:game_stats) { FactoryGirl.create(:game_stats, game_id: game.id, player_id: player.id) }

        it 'should not create a new game stats' do
          expect { do_action }.to_not change { GameStats.count }
        end

        it 'should update existing game stats attributes' do
          expect { do_action }.to change { game_stats.reload.attributes }
        end
      end
    end

    context 'when away team player exists (fantasy draft pick)' do
      let!(:player) { FactoryGirl.create(:player, id: '8e288d6e-50b8-404b-812b-823ae5bab61f') }

      it 'should create a new game stats' do
        expect { do_action }.to change { GameStats.count }
        expect(new_game_stats.points).to eq 12
      end

      it 'should create a new game stats for game/player' do
        do_action
        expect(new_game_stats.game).to eq game
        expect(new_game_stats.player).to eq player
      end
    end
  end
end
