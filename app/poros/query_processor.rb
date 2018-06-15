class QueryProcessor

  def self.new_query(query_text)
  	query = query_text.gsub(/\s/, "+")
    query_response = JSON.parse(open("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{query}&key=#{ENV['API_KEY']}").read)
    begin
      location = query_response['results'][0]['geometry']['location']
    rescue
      return
    end
    latitude = location['lat']
    longitude = location['lng']
    LocationQuery.create(query: query, latitude: latitude, longitude: longitude)
  end

end