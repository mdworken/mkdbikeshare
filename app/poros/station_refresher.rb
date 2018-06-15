class StationRefresher
  
  def self.refresh(id)
    data_source =  BikeshareFeedProcessor.current_data
    station_data = data_source.at("id:contains(#{id})").parent
    num_bikes = station_data.css("nbBikes").text
    num_docks = station_data.css("nbEmptyDocks").text
    Station.update(id, :num_bikes => num_bikes, :num_docks => num_docks)
    Station.find(id)
  end

  def self.refresh_all
    Station.find_each do |station|
      id = station.id
      StationRefresher.refresh(id)
    end
  end

  def self.load_all
    data_source = BikeshareFeedProcessor.current_data
    (1..526).each do |id| #coded magic number - will remove later
      begin
        station_data = data_source.at("id:contains(#{id})").parent
        station = Station.find_or_create_by(id: id)
        station.lat = station_data.css("lat").text
        station.lng = station_data.css("long").text
        station.name = station_data.css("name").text
        station.update_attributes
      rescue
        #station id was one of the couple invalid ones
      end
    end
    StationRefresher.refresh_all
  end
end