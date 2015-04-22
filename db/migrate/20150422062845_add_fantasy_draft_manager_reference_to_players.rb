class AddFantasyDraftManagerReferenceToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :fantasy_draft_manager_id, :integer
    add_index :players, :fantasy_draft_manager_id
  end
end
