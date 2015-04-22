class Player < ActiveRecord::Base
  self.primary_key = 'id'

  belongs_to :fantasy_draft_manager, class_name: 'User'

  validates :first_name, :last_name, :position, :primary_position, :jersey_number, presence: true
  validates :id, presence: true, uniqueness: true
end
