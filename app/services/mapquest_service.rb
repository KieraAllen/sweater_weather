class MapquestService
  def initialize(location)
    @location = location
  end

  def get_coordinates
    response = conn.get("/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{location}")
    JSON.parse(response.body)["results"].first["locations"].first["latLng"]
  end

  def get_eta(end_location)
    response = conn.get("directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{location}&to=#{end_location}")
    JSON.parse(response.body)["route"]["time"]
    #  time is in given in seconds for the route from MapQuest
  end

  private

  attr_reader :location

  def conn
    Faraday.new(url: "http://www.mapquestapi.com")
  end
end
