class LocationQuery < ActiveRecord::Base
  attr_accessible :geocoder_response_id, :name
end
