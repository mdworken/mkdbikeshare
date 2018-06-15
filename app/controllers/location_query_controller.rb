class LocationQueryController < ApplicationController

  def slack_query
    query_text = params[:query_text]
    if LocationQuery.exists?(query_text)
      @location = LocationQuery.first(query_text)
    end
    

  end 





  def send_nearby_stations_to_slack
    #TODO put this in a concern (or PORO?) to DRY things up?
    payload = Hash.new
    payload[:channel] = '#bikeshare'
    payload[:username] = 'mkd Bikeshare'
    
    text = "Here are your nearest stations!\n"
    @nearby_stations.each do |station|
      text << "Station Name: #{station.name}\n"
      text << "Station Id: #{station.id}  "
      text << "Bikes Available: #{station.num_bikes}  "
      text << "Docks Available: #{station.num_docks}\n\n"
    end
    payload[:text] = text
    
    Net::HTTP.post URI(ENV['SLACK_WEBHOOK']),
               payload.to_json,
               "Content-Type" => "application/json"
  end



end
