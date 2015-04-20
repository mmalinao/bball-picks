class CreateGames < ActiveRecord::Migration
  def change
    create_table :games, id: false do |t|
      t.string :id, null: false

      t.string :title
      t.string :status
      t.string :coverage
      t.datetime :scheduled
    end

    add_index :games, :id, unique: true
  end
end
