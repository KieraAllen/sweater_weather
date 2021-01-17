class ForecastFacade
  def initialize(location)
    @location = location
  end

  def forecast
    coordinates = mapquest_service.get_coordinates
    # step 2: use the coordinates to get the weather
    forecast = openweather_service(coordinates).get_forecast
    # step 3: create poro
    Forecast.new(forecast)
  end

  private

  attr_reader :location

  def mapquest_service
    MapquestService.new(location)
  end

  def openweather_service(coordinates)
    OpenweatherService.new(coordinates)
  end
end
