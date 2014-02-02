# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


cities_path = Rails.root.join('db', 'seeds', 'cities.txt')

open(cities_path, 'rb').readlines.map{|x| x.strip}.each do |city|
 
  query = LocationQuery.build_from_query(city)

  if query.new_record?
    puts "Geocoded #{city}"
    query.save
    sleep 0.1
  else
    puts "Already geocoded #{city}"
  end
end

Location.responses_to_locations(GeocoderResponse.all)