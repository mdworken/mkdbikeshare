require 'test_helper'
class StationTest < ActiveSupport::TestCase

  describe 'validations' do
  	it 'should reject invalid ids' do
  	  assert_not Station.create(id: 0, num_bikes: 137, num_docks: 137).valid_id?
      assert Station.create(id: 35).updated_at
  	  assert_nil Station.create(id: "YOLO", num_bikes: 157, num_docks: 147).updated_at
  	  assert_not Station.new(id: 2000).valid?
  	end 

    it 'should accept valid ids' do
      assert_empty Station.all
      assert Station.create(id:33)
      assert_not_empty Station.all
    end
  
  end
end