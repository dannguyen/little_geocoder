class CreateLocationQueries < ActiveRecord::Migration
  def change
    create_table :location_queries do |t|
      t.string :name

      t.timestamps
    end
  end
end
