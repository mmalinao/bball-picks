class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, id: false do |t|
      t.string :id, null: false

      t.string :name
      t.string :alias_name
      t.string :market
    end

    add_index :teams, :id, unique: true
  end
end
