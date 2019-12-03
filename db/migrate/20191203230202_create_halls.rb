class CreateHalls < ActiveRecord::Migration[6.0]
  def change
    create_table :halls do |t|
      t.string :name
      t.string :address
      t.integer :seats
      t.references :theatre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
