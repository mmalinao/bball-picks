class CreateGameSummaries < ActiveRecord::Migration
  def change
    create_table :game_summaries, id: false do |t|
      t.string :id, null: false

      t.string :title
      t.string :status
      t.string :coverage
      t.datetime :scheduled
      t.string :clock
      t.integer :quarter
    end

    add_index :game_summaries, :id, unique: true
  end
end
