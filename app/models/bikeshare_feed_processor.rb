require 'nokogiri'
require 'open-uri'
class BikeshareFeedProcessor

  @@last_refreshed = nil
  
  def self.refresh
  	@@last_refreshed = Time.now
    @@current_data = Nokogiri::XML(open("https://feeds.capitalbikeshare.com/stations/stations.xml"))
  end
  
  def self.needs_refresh?
    @@last_refreshed.nil? or (Time.now - @@last_refreshed > 7.seconds)
  end
  
  def self.current_data
    refresh if needs_refresh?
    @@current_data
  end
  
end