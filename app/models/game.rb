class Game < ActiveRecord::Base
  self.primary_key = 'id'

  belongs_to :series, inverse_of: :games
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  validates :title, :status, :coverage, :scheduled, presence: true
  validates :id, presence: true, uniqueness: true

  scope :closed, -> { where(status: 'closed') }
  scope :inprogress, -> { where(status: 'inprogress') }
  scope :scheduled, -> { where(status: 'scheduled') }
  scope :inprogress_or_scheduled, -> { where(status: ['inprogress', 'scheduled']) }

  def self.permitted_params
    [:title, :status, :coverage, :scheduled, :series_id]
  end

  # def refresh(force = false)
  #   if !closed? || force
  #     refresh_stats
  #     true
  #   else
  #     false
  #   end
  # end

  def refresh_stats
    game_summary_data = SportRadarApi.game_summary(id)
    refresh_from(game_summary_data)

    game_summary = GameSummary.where(id: game_summary_data[:id]).first_or_initialize
    game_summary.refresh_from(game_summary_data)
  end

  def refresh_from(game_data)
    assign_attributes game_data.slice(*Game.permitted_params).merge!(home_team_id: game_data[:home][:id], away_team_id: game_data[:away][:id])
    save
  end

  def display_title
    "#{away_team.alias_name} @ #{home_team.alias_name} - #{title}"
  end

  def closed?
    status == 'closed'
  end

  def inprogress?
    status == 'inprogress'
  end

  def scheduled?
    status == 'scheduled'
  end
end
