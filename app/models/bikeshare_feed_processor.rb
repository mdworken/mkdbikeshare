require 'nokogiri'
require 'open-uri'
class BikeshareFeedProcessor

  class_attribute :last_refreshed

  REFRESH_AFTER = 7.seconds

  def self.refresh
    BikeshareFeedProcessor.last_refreshed = DateTime.now
    @@current_data = Nokogiri::XML(open("https://feeds.capitalbikeshare.com/stations/stations.xml"))
  end
  
  def self.refresh_and_time
    time_before = DateTime.now
    BikeshareFeedProcessor.refresh
    time_after = DateTime.now
    time_diff = (time_after - time_before).seconds
  end

  def self.needs_refresh?
    BikeshareFeedProcessor.last_refreshed.nil? or (DateTime.now - BikeshareFeedProcessor.last_refreshed > REFRESH_AFTER)
  end
  
  def self.current_data
    refresh if needs_refresh?
    @@current_data
  end

  #TODO This method is included only for testing purposes. Look into keeping it out of production? 
  def self.set_data(data, last_refreshed=DateTime.now)
    @@current_data=data
    BikeshareFeedProcessor.last_refreshed = last_refreshed
  end
end