class ChangeSeriesIdToStringOnGames < ActiveRecord::Migration
  def change
    change_column :games, :series_id, :string
  end
end
