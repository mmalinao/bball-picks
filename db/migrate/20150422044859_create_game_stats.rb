class CreateGameStats < ActiveRecord::Migration
  def change
    create_table :game_stats, id: false do |t|
      t.string :game_id
      t.string :player_id
      t.integer :points

      t.timestamps null: false
    end

    add_index :game_stats, ['game_id', 'player_id'], unique: true
  end
end
