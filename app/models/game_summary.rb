class GameSummary < ActiveRecord::Base
  self.primary_key = 'id'

  validates :title, :status, :coverage, :scheduled, :clock, :quarter, presence: true
  validates :id, presence: true, uniqueness: true
end
