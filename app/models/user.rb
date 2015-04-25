class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: { regular: 0, admin: 1 }

  has_many :picks, class_name: 'Player', foreign_key: 'fantasy_draft_manager_id'

  validates :user_name, presence: true

  def total_points
    points = 0
    picks.includes(:game_stats).each do |pick|
      points += pick.game_stats.sum(:points)
    end
    points
  end

  def top_pick
    top_pick = picks.max_by { |pick| pick.total_points }
  end
end
