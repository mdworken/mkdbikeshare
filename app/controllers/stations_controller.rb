class StationsController < ApplicationController
  before_action :validate_ids, only: :index

  def index
    @stations = []
    @station_id_array = params[:ids]
    @station_id_array.each do |id|
      station = Station.find_or_create_by(id: id)
      @stations << StationRefresher.refresh(id)
    end
    render "bs"
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

  def validated(id)
     id.to_i > 0 and id.to_i <=526 #current max id, hardcoding for now
  end
end