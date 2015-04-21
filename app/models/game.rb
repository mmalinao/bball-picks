class Game < ActiveRecord::Base
  self.primary_key = 'id'

  belongs_to :series, inverse_of: :games

  validates :title, :status, :coverage, :scheduled, presence: true
  validates :id, presence: true, uniqueness: true

  def self.refresh_from(game_data)
    game = Game.where(id: game_data[:id]).first_or_initialize
    game.assign_attributes game_data.slice(*Game.permitted_params)
    game.save
  end

  def self.permitted_params
    [:title, :status, :coverage, :scheduled, :series_id]
  end
end
