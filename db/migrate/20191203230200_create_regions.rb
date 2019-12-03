class CreateRegions < ActiveRecord::Migration[5.1]
    def change
        create_table :regions do |t|
            t.string :name
            t.string :type
            t.belongs_to :parent, foreign_key: { to_table: :regions }
            t.timestamps
        end
    end
end
