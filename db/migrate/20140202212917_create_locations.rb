class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :short_name
      t.string :long_name
      t.string :type
      t.decimal :lat
      t.decimal :lng
      t.text :geometry
      t.integer :parent_id

      t.timestamps
    end
  end
end
