require 'test_helper'
require 'nokogiri'
class BikeshareFeedProcessorTest < ActiveSupport::TestCase

  describe 'updating' do

    before do
      BikeshareFeedProcessor.last_refreshed = nil
    end

    it 'should track datetime of refresh' do
      assert_nil BikeshareFeedProcessor.last_refreshed
      BikeshareFeedProcessor.refresh
      assert_kind_of DateTime, BikeshareFeedProcessor.last_refreshed
    end

    it 'should allow manual setting of data' do
      BikeshareFeedProcessor.set_data 'test/fixtures/files/test_xml_file.xml'
      assert_in_delta(BikeshareFeedProcessor.last_refreshed, DateTime.now, 2.seconds)
      test_data = BikeshareFeedProcessor.current_data
      fake_station = Station.create(id: 33, num_bikes: 10000)
      fake_station = StationRefresher.refresh(33)
      assert fake_station.name == "Dance Dance Dance"
      assert fake_station.num_bikes == 2222
      
      assert BikeshareFeedProcessor.refresh
      real_station = StationRefresher.refresh(33)    
      assert real_station.name == "Park Rd & Holmead Pl NW"
      assert real_station.num_bikes != 2222
    end 
    
    it 'should refresh reasonably quickly' do
      assert BikeshareFeedProcessor.refresh_and_time < 0.5.seconds
    end

    after do
      BikeshareFeedProcessor.refresh
    end
  end
end 