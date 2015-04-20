class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable

  validates :user_name, presence: true
end
