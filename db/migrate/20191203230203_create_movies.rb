class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :director_name
      t.date :release_date
      t.boolean :is_active

      t.timestamps
    end
  end
end
