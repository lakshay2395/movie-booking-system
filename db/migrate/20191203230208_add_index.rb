class AddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :shows, [:hall_id, :movie_id, :timing_id], unique: true
    add_index :users, [:email_id], unique: true
  end
end
