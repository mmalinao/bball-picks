class Team < ActiveRecord::Base
  self.primary_key = 'id'

  validates :id, presence: true, uniqueness: true
  validates :name, :alias_name, :market, presence: true
end
