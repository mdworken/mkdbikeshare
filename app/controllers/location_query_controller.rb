class LocationQueryController < ApplicationController

  def slack_query
    query_text = params[:text]
    @query_text = query_text
    if LocationQuery.exists?(query_text)
      location = LocationQuery.first(query: query_text)
    else
      location = QueryProcessor.new_query(query_text)
    end
    render html: "Uh oh! We couldn't find a location for that query." and return if location.nil?
    station_id_array = StationFinder.nearest_stations(location)
    @nearby_stations = []
    station_id_array.each do |station_id|
      id = station_id[0] #it's reported as the first element in each key, value pair reported array
      StationRefresher.refresh(id)
      @nearby_stations << Station.find(id)
    end
    @location=location
    text = send_nearby_stations_to_slack
    render html: text
  end 


  def send_nearby_stations_to_slack
    #TODO put this in a concern (or PORO?) to DRY things up? 
    payload = Hash.new
    payload[:channel] = '#bikeshare'
    payload[:username] = 'mkd Bikeshare'
    
    text = "Here are your nearest stations to the location we found for #{@location.query}\n"
    @nearby_stations.each do |station|
      text << "Station Name: #{station.name}\n"
      text << "Station Id: #{station.id}  "
      text << "Bikes Available: #{station.num_bikes}  "
      text << "Docks Available: #{station.num_docks}\n\ \n"
    end
    
    text

    #payload[:text] = text
    
    #Net::HTTP.post URI(ENV['SLACK_WEBHOOK']),
    #           payload.to_json,
    #           "Content-Type" => "application/json"
  end

end
