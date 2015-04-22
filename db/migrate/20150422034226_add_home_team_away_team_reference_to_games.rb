class AddHomeTeamAwayTeamReferenceToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_team_id, :string
    add_column :games, :away_team_id, :string

    add_index :games, :home_team_id
    add_index :games, :away_team_id
  end
end
