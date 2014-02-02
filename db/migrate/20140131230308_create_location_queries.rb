class CreateLocationQueries < ActiveRecord::Migration
  def change
    create_table :location_queries do |t|
      t.string :name
      t.integer :geocoder_response_id

      t.timestamps
    end
  end
end
