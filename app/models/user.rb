class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable

  has_many :picks, class_name: 'Player', foreign_key: 'fantasy_draft_manager_id'

  validates :user_name, presence: true
end
