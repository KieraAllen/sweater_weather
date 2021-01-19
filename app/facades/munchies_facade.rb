class MunchiesFacade
  def initialize(info)
    @start = info[:start]
    @end_location = info[:end_location]
    @food = info[:food]
  end

  def munchies
    eta = mapquest_service.get_eta(end_location)
    # eta will be a number (in seconds) that represents the time it takes to get to end location
    restaurant_info = yelp_service.get_info(end_location, food, time_at_arrival(eta))
    forecast_info = openweather_service.get_forecast
    Munchies.new(eta, restaurant_info, forecast_info)
  end

  private

  attr_reader :start,
              :end_location,
              :food

  def mapquest_service
    MapquestService.new(start)
  end

  def yelp_service
    YelpService.new
  end

  def openweather_service
    OpenweatherService.new(end_location)
  end

  def time_at_arrival(seconds_from_now)
    Time.now.to_i + seconds_from_now
  end
end
