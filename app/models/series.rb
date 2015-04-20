class Series < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :games

  validates :id, presence: true, uniqueness: true
  validates :title, :status, :start_date, :round, presence: true
end
