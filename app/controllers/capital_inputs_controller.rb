class CapitalInputsController < ApplicationController

  def manually_refresh
  	time_before = Time.now
    CapitalInput.refresh
    time_after = Time.now
    @time_diff = (time_after - time_before).seconds
    render 'refresh'
  end


end
