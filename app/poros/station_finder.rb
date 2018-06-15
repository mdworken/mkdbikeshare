class StationFinder

  def self.nearest_stations(location_query, num_stations = 6)
    score_hash = Hash.new
    x = location_query.latitude
    y = location_query.longitude
    Station.find_each do |station|
      score_hash[station.id] = (x*10000 - station.latitude*10000).abs + (y*10000 - station.longitude*10000).abs
    end
    score_hash.min_by(num_stations) {|k,v| v}
  end

end