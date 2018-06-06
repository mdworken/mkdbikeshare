class StationRefresher
  
  def self.refresh(id)
    data_source =  CapitalInput.current_data
    station_data = data_source.at("id:contains(#{id})").parent
    num_bikes = station_data.css("nbBikes").text
    num_docks = station_data.css("nbEmptyDocks").text
    Station.update(id, :num_bikes => num_bikes, :num_docks => num_docks)
  end

  def self.refresh_all
    #TODO @todo = 3
  end

end