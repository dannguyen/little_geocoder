class LocationQuery < ActiveRecord::Base
  attr_accessible :name
  validates_uniqueness_of :name

  has_many :geocoder_responses

  # str is a query
  #
  # returns new unsaved LocationQuery

  def self.build_from_query(str)
    query = self.where(name: str).first_or_initialize
    if query.new_record?
      results = Geocoder.search(query.name)
      results.each do |res|
        query.geocoder_responses.build(data: res.data)
      end
    end

    return query
  end


end
