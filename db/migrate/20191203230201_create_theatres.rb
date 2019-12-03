class CreateTheatres < ActiveRecord::Migration[6.0]
  def change
    create_table :theatres do |t|
      t.string :name
      t.string :address
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
