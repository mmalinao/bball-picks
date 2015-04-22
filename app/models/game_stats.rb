class GameStats < ActiveRecord::Base
  self.primary_keys = :game_id, :player_id

  belongs_to :game
  belongs_to :player

  def self.permitted_params
    [:points]
  end

  def refresh_from(stats)
    assign_attributes stats.slice(*GameStats.permitted_params)
    save
  end
end
