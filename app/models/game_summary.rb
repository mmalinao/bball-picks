class GameSummary < ActiveRecord::Base
  self.primary_key = 'id'

  validates :title, :status, :coverage, :scheduled, :clock, :quarter, presence: true
  validates :id, presence: true, uniqueness: true

  # rubocop:disable all
  def self.refresh(game_id)
    game_summary_data = SportRadarApi.game_summary(game_id)
    game_summary = GameSummary.where(id: game_summary_data[:id]).first_or_initialize
    game_summary.refresh_from(game_summary_data)

    # Check player stats on home team
    game_summary_data[:home][:players].each do |player_data|
      if Player.exists?(id: player_data[:id])
        game_stats = GameStats.where(game_id: game_id, player_id: player_data[:id]).first_or_initialize
        game_stats.refresh_from(player_data[:statistics])
      end
    end
    # Check player stats on away team
    game_summary_data[:away][:players].each do |player_data|
      if Player.exists?(id: player_data[:id])
        game_stats = GameStats.where(game_id: game_id, player_id: player_data[:id]).first_or_initialize
        game_stats.refresh_from(player_data[:statistics])
      end
    end
  end
  # rubocop:enable all

  def self.permitted_params
    [:title, :status, :coverage, :scheduled, :clock, :quarter]
  end

  def refresh_from(game_summary_data)
    assign_attributes game_summary_data.slice(*GameSummary.permitted_params)
    save
  end
end
