require 'open-uri'
require 'uri'
require 'json'
require 'net/http'
class StationsController < ApplicationController
  before_action :validate_ids, only: :index

  def index
    @stations = []
    @station_id_array = params[:ids]
    @station_id_array.each do |id|
      station = Station.find_or_create_by(id: id)
      @stations << StationRefresher.refresh(id)
    end
    if params[:api_only] == "true"
      send_stations_to_slack
      render html: "Neat!"
    else 
      render "display_results"
    end 
  end

  def invalid
    render 'invalid'
  end


  private

  def validate_ids
    @invalid_ids = []
    id_array = params[:ids]
    id_array.each do |id|
      @invalid_ids << id unless validated id
    end
    
    render 'invalid' unless @invalid_ids.empty?
  end
  
  def send_stations_to_slack
    #TODO put this in a concern (or PORO?) to DRY things up?
    payload = Hash.new
    payload[:channel] = '#bikeshare'
    payload[:username] = 'mkd Bikeshare'
    
    text = ''
    @stations.each do |station|
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

  def validated(id)
     id.to_i > 0 and id.to_i <=526 #current max id, hardcoding for now
  end
end