require 'test_helper'
require 'nokogiri'
require 'application_system_test_case'
class BikeshareFeedProcessorTest  < ApplicationSystemTestCase

  describe 'calling' do


    it 'should be able to report manually set data' do
      BikeshareFeedProcessor.set_data 'test/fixtures/files/test_xml_file.xml'
      assert_in_delta(BikeshareFeedProcessor.last_refreshed, DateTime.now, 2.seconds)
      test_data = BikeshareFeedProcessor.current_data
      fake_station = Station.create(id: 33, num_bikes: 10000, num_docks: 33)
      fake_station = StationRefresher.refresh(33)
      params = {ids:[33], api_only: true}.to_query
      address = '/stations?' + params
      visit address
      json_response = JSON.parse(response.body)
      assert_equal json_response[:text], 5
    end

  end
end 