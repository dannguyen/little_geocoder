class Location < ActiveRecord::Base
  has_ancestry
  attr_accessible :geometry, :lat, :lng, :long_name, :short_name, :type
  serialize :geometry, Hash

  validates_uniqueness_of :long_name, scope: [:type, :ancestry]

  ADDRESS_COMPONENTS_TO_TYPES = {
    'country' => 'Country',
    'administrative_area_level_1' => 'State',
    'administrative_area_level_2' => 'County',
    'locality' => 'Locality',
    'sublocality' => 'SubLocality',
    'neighborhood' => 'Neighborhood'
  }

  # returns comma-delimited parts: e.g. city, county, state, country
  def full_name
    (self.ancestors.to_a << self).reverse.map{|a| a.long_name}.join(', ')

  end

  # results is an Array of Google-like geocoder response results

  # returns an Array of built Locations
  def self.responses_to_locations(responses)
    responses = Array(responses)
    
    responses.inject([]) do |arr, resp|
      types_and_components = ordered_components_by_type resp.data['address_components']
      prev_loc = nil
      types_and_components.each do |(_type, c)|        
        loc = Location.where( short_name: c['short_name'], long_name: c['long_name'], type: _type).first_or_initialize
        loc.parent = prev_loc

        if loc.valid?
          loc.save
          prev_loc = loc
        end
      end
    end
  end


  def self.component_type_lookup(str)
    ADDRESS_COMPONENTS_TO_TYPES[str]
  end

  def self.ordered_components_by_type(a)
    types = ADDRESS_COMPONENTS_TO_TYPES.values
    arr = a.map{|c|  _type = component_type_lookup(c['types'].find{|t| t != 'political' }); _type.present? ? [_type, c] : nil }

    return arr.compact.sort_by{|(t,v)| types.index(t) }
  end

end
