class Forecast

  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(forecast_info)
    @id = nil
    @current_weather = format_current_weather(forecast_info["current"])
    @daily_weather = format_daily_weather(forecast_info["daily"])
    @hourly_weather = format_hourly_weather(forecast_info["hourly"])
  end

  private
  def format_current_weather(info)
    {
      datetime: Time.at(info["dt"]).to_s,
      sunrise: Time.at(info["sunrise"]).to_s,
      sunset: Time.at(info["sunset"]).to_s,
      temperature: info["temp"],
      feels_like: info["feels_like"],
      humidity: info["humidity"],
      uvi: info["uvi"],
      visibility: info["visibility"],
      conditions: info["weather"].first["description"],
      icon: info["weather"].first["icon"]
    }
  end

  def format_daily_weather(info)
    info[0..4].map do |day|
      {
        date: Time.at(day["dt"]).to_date.to_s,
        sunrise: Time.at(day["sunrise"]).to_s,
        sunset: Time.at(day["sunset"]).to_s,
        max_temp: day["temp"]["max"],
        min_temp: day["temp"]["min"],
        conditions: day["weather"].first["description"],
        icon: day["weather"].first["icon"]
      }
    end
  end

  def format_hourly_weather(info)
    info[0..7].map do |hour|
      {
        time: Time.at(hour["dt"]).strftime("%H:%M:%S"),
        temperature: hour["temp"],
        wind_speed: hour["wind_speed"].to_s + " mph",
        wind_direction: convert_to_wind_direction(hour["wind_deg"]),
        conditions: hour["weather"].first["description"],
        icon: hour["weather"].first["icon"]
      }
    end
  end

  def convert_to_wind_direction(degree)
    if degree >= 22.5 && degree < 67.5
      'North Easterly'
    elsif degree >= 67.5 && degree < 112.5
      'Easterly'
    elsif degree >= 122.5 && degree < 157.5
      'South Easterly'
    elsif degree >= 157.5 && degree < 202.5
      'Southerly'
    elsif degree >= 202.5 && degree < 247.5
      'South Westerly'
    elsif degree >= 247.5 && degree < 292.5
      'Westerly'
    elsif degree >= 292.5 && degree < 337.5
      'North Westerly'
    else
      'Northerly'
    end
  end
end
