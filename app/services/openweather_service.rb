class OpenweatherService
  def initialize(coordinates)
    @lat = coordinates["lat"]
    @lng = coordinates["lng"]
  end

  def get_forecast
    response = conn.get("/data/2.5/onecall?lat=#{lat}&lon=#{lng}&exclude=minutely,alerts&appid=#{ENV["OPENWEATHER_KEY"]}")
    JSON.parse(response.body)
  end

  private

  attr_reader :lat,
              :lng

  def conn
    Faraday.new(url: "https://api.openweathermap.org")
  end
end
