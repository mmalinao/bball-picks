class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series, id: false do |t|
      t.string :id, null: false

      t.string :title
      t.string :status
      t.date :start_date
      t.integer :round
    end

    add_index :series, :id, unique: true
  end
end
