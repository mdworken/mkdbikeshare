require 'test_helper'
require 'nokogiri'
require 'application_system_test_case'
class BikeshareFeedProcessorTest  < ApplicationSystemTestCase

  describe 'updating' do

    before do
      BikeshareFeedProcessor.last_refreshed = nil
    end

    it 'should be able to report manually set data' do
      BikeshareFeedProcessor.set_data 'test/fixtures/files/test_xml_file.xml'
      assert_in_delta(BikeshareFeedProcessor.last_refreshed, DateTime.now, 2.seconds)
      test_data = BikeshareFeedProcessor.current_data
      fake_station = Station.create(id: 33, num_bikes: 10000, num_docks: 33)
      fake_station = StationRefresher.refresh(33)
      visit '/stations?ids[]=33&api_only=true'
      json_response = JSON.parse(response.body)
      assert_equal json_response[:text], 5
    end

    after do
      BikeshareFeedProcessor.refresh
    end
  end
end 