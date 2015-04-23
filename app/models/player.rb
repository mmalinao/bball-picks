class Player < ActiveRecord::Base
  self.primary_key = 'id'

  belongs_to :fantasy_draft_manager, class_name: 'User'
  belongs_to :team

  validates :first_name, :last_name, :position, :primary_position, :jersey_number, presence: true
  validates :id, presence: true, uniqueness: true

  def self.pick(id, fantasy_draft_manager)
    pick = Player.where(id: id).first_or_initialize do |player|
      player_data = SportRadarApi.player_profile(id)
      player.refresh_from(player_data)
    end
    pick.fantasy_draft_manager = fantasy_draft_manager
    pick.save
  end

  def self.permitted_params
    [:first_name, :last_name, :position, :primary_position, :jersey_number]
  end

  def refresh_from(player_data)
    assign_attributes player_data.slice(*Player.permitted_params)
  end
end
