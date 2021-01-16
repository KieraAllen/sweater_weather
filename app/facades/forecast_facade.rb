class ForecastFacade
  def initialize(location)
    @location = location
  end

  def forecast
    # step 1: use the location to get the coordinates
    coordinates = mapquest_service.get_coordinates

    # step 2: use the coordinates to get the weather
    # step 3: format using the serializer
  end

  private

  attr_reader :location

  def mapquest_service
    MapquestService.new(location)
  end
end
