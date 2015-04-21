class Series < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :games, inverse_of: :series

  validates :id, presence: true, uniqueness: true
  validates :title, :status, :start_date, :round, presence: true

  def self.refresh
    data = SportRadarApi.schedules
    data[:series].each { |series_data| Series.refresh_from series_data }
  end

  def self.refresh_from(series_data)
    series = Series.where(id: series_data[:id]).first_or_initialize
    series.assign_attributes series_data.slice(*Series.permitted_params)
    series_data[:games].each { |game_data| Game.refresh_from(game_data.merge!(series_id: series_data[:id])) }

    series.save
  end

  def self.permitted_params
    [:title, :status, :start_date, :round]
  end
end
