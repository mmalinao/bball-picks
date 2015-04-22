class Player < ActiveRecord::Base
  self.primary_key = 'id'

  validates :first_name, :last_name, :position, :primary_position, :jersey_number, presence: true
  validates :id, presence: true, uniqueness: true
end
