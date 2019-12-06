class AddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :shows, [:hall_id, :movie_id,:show_date, :timing_id], unique: true, name: 'unique_show_index'
    add_index :users, [:email_id], unique: true
  end
end
