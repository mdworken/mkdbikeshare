require 'test_helper'
class BikeshareFeedProcessorTest < ActiveSupport::TestCase

  describe 'updating' do
  
    it 'should track datetime of refresh' do
      assert_nil BikeshareFeedProcessor.last_refreshed
      BikeshareFeedProcessor.refresh
      assert_kind_of DateTime, BikeshareFeedProcessor.last_refreshed
    end 

  end

end