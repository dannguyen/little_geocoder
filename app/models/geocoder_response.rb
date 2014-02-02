class GeocoderResponse < ActiveRecord::Base
  attr_accessible :location_query_id, :data
  serialize :data, Hash

  belongs_to :location_query


end
