require 'test_helper'

class SlackApiCallsTest < ActionDispatch::IntegrationTest
  
  it "the truth" do
     assert true
  end

  it "stations" do
  	ids = ["33", "34"]
    get '/stations', params: {'ids[]': ids , 'api_only': "true"}
  end
end
