class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable

  validates :user, presence: true
end
