class LocationQuery < ApplicationRecord

  def example_query
    @query_response = JSON.parse(open("https://maps.googleapis.com/maps/api/place/textsearch/json?query=Power+Auctions+LLC&key=#{ENV['API_KEY']}").read)
    @location = @query_response['results'][0]['geometry']['location']
    @lat = @location['lat']
    @long = @location['lng']
  end

end
