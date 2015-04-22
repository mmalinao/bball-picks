class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :picks, class_name: 'Player', foreign_key: 'fantasy_draft_manager_id'

  validates :user_name, presence: true
end
