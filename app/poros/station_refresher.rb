class StationRefresher
  
  def self.refresh(id)
    data_source =  BikeshareFeedProcessor.current_data
    station_data = data_source.at("id:contains(#{id})").parent
    name = station_data.css("name").text
    num_bikes = station_data.css("nbBikes").text
    num_docks = station_data.css("nbEmptyDocks").text
    Station.update(id, :num_bikes => num_bikes, :num_docks => num_docks, :name => name)
    Station.find(id)
  end

  def self.refresh_all
    stations=Station.all
    stations.each do |station|
      id = station.id
      StationRefresher.refresh(id)
    end
  end

end