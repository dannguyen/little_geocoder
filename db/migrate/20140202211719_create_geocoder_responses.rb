class CreateGeocoderResponses < ActiveRecord::Migration
  def change
    create_table :geocoder_responses do |t|
      t.integer :location_query_id
      t.text :data

      t.timestamps
    end
  end
end
