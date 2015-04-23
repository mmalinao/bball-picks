class AddTeamReferenceToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :team_id, :string
    add_index :players, :team_id
  end
end
