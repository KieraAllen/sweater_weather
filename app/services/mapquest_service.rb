class MapquestService
  def initialize(location)
    @location = location
  end

  def get_coordinates
    response = conn.get("/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{location}")
    JSON.parse(response.body)["results"].first["locations"].first["latLng"]
  end

  private

  attr_reader :location

  def conn
    Faraday.new(url: "http://www.mapquestapi.com")
  end
end
