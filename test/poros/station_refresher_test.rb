require 'test_helper'
class StationRefresherTest < ActiveSupport::TestCase
  
  describe 'it should fill in the number of bikes/docks' do |variable|
  	before do
      station_1 = Station.create(id: 33, num_bikes: 500, num_docks: 550)
      station_2 = Station.create(id: 34, num_bikes: 70)
      station_3 = Station.create(id: 35, num_bikes: 400, num_docks: 450)
      station_4 = Station.create(id: 36, num_docks: 70)
  	end

    it 'should update data that has already been defined' do
      station_1 = Station.find(33)
      assert_equal station_1.num_bikes, 500

      StationRefresher.refresh(33)
      station_1 = Station.find(33)
      assert_not_equal station_1.num_bikes, 500
      assert_not_equal station_1.num_docks, 550
    end

    it 'should update data when one field is nil' do
      station_2 = Station.find(34)
      assert_equal station_2.num_bikes, 70
      assert_nil station_2.num_docks

      StationRefresher.refresh(34)
      station_2 = Station.find(34)
      assert_not_nil station_2.num_docks
      assert_not_equal station_2.num_bikes, 70
    end

    it 'should be able to refresh all' do
      station_3 = Station.find(35)
      assert_equal station_3.num_bikes, 400
      
      station_4 = Station.find(36)
      assert_equal station_4.num_docks, 70
      assert_nil station_4.num_bikes

      StationRefresher.refresh_all
      
      station_3 = Station.find(35)
      assert_not_equal station_3.num_bikes, 400
      
      station_4 = Station.find(36)
      assert_not_equal station_4.num_docks, 70
      assert_not_nil station_4.num_bikes
    end

  end
end