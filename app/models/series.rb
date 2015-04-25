class Series < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :games, inverse_of: :series

  validates :id, presence: true, uniqueness: true
  validates :title, :status, :start_date, :round, presence: true

  scope :closed, -> { where(status: 'closed') }
  scope :inprogress, -> { where(status: 'inprogress') }
  scope :scheduled, -> { where(status: 'scheduled') }

  def self.refresh
    data = SportRadarApi.schedules
    data[:series].each do |series_data|
      series = Series.where(id: series_data[:id]).first_or_initialize
      series.refresh_from(series_data)
    end
  end

  def self.permitted_params
    [:title, :status, :start_date, :round]
  end

  def refresh_from(series_data)
    assign_attributes series_data.slice(*Series.permitted_params)
    series_data[:games].each do |game_data|
      game = Game.where(id: game_data[:id]).first_or_initialize
      game.refresh_from(game_data.merge!(series_id: series_data[:id]))
    end

    save
  end
end
