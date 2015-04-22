class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players, id: false do |t|
      t.string :id, null: false

      t.string :first_name
      t.string :last_name
      t.string :position
      t.string :primary_position
      t.string :jersey_number
    end

    add_index :players, :id, unique: true
  end
end
