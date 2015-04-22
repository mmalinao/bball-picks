class Team < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :home_games, class_name: 'Game', foreign_key: 'home_game_id'
  has_many :away_games, class_name: 'Game', foreign_key: 'away_game_id'

  validates :id, presence: true, uniqueness: true
  validates :name, :alias_name, :market, presence: true

  def self.refresh
    data = SportRadarApi.teams
    data[:conferences].each do |conference_data|
      conference_data[:divisions].each do |division_data|
        division_data[:teams].each do |team_data|
          team = Team.where(id: team_data[:id]).first_or_initialize
          team.refresh_from(team_data)
        end
      end
    end
  end

  def self.permitted_params
    [:name, :alias_name, :market]
  end

  def refresh_from(team_data)
    team_data[:alias_name] = team_data.delete :alias
    assign_attributes team_data.slice(*Team.permitted_params)
    save
  end
end
