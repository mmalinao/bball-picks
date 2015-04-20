class AddSeriesReferenceToGames < ActiveRecord::Migration
  def change
    add_reference :games, :series, index: true
  end
end
