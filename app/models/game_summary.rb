class GameSummary < ActiveRecord::Base
  self.primary_key = 'id'

  validates :title, :status, :coverage, :scheduled, :clock, :quarter, presence: true
  validates :id, presence: true, uniqueness: true

  def self.refresh(game_id)
    game_summary_data = SportRadarApi.game_summary(game_id)
    game_summary = GameSummary.where(id: game_summary_data[:id]).first_or_initialize
    game_summary.refresh_from(game_summary_data)
  end

  def self.permitted_params
    [:title, :status, :coverage, :scheduled, :clock, :quarter]
  end

  def refresh_from(game_summary_data)
    assign_attributes game_summary_data.slice(*GameSummary.permitted_params)
    save
  end
end
