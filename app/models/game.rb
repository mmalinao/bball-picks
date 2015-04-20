class Game < ActiveRecord::Base
  self.primary_key = 'id'

  validates :title, :status, :coverage, :scheduled, presence: true
  validates :id, presence: true, uniqueness: true
end
