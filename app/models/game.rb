class Game < ActiveRecord::Base
  self.primary_key = 'id'

  belongs_to :series, inverse_of: :games
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  validates :title, :status, :coverage, :scheduled, presence: true
  validates :id, presence: true, uniqueness: true

  def self.permitted_params
    [:title, :status, :coverage, :scheduled, :series_id]
  end

  def refresh_from(game_data)
    assign_attributes game_data.slice(*Game.permitted_params).merge!(home_team_id: game_data[:home][:id], away_team_id: game_data[:away][:id])
    save
  end
end
