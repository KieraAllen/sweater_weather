require 'rails_helper'

describe Forecast do
  before :each do
    forecast_info = {
      "lat" => 39.7385,
      "lon" => -104.9849,
      "timezone" => "America/Denver",
      "timezone_offset" => -25200,
      "current" => {
        "dt" => 1610994697,
        "sunrise" => 1610979458,
        "sunset" => 1611014575,
        "temp" => 275.09,
        "feels_like" => 271.29,
        "pressure" => 1018,
        "humidity" => 49,
        "dew_point" => 266.36,
        "uvi" => 1.96,
        "clouds" => 18,
        "visibility" => 10000,
        "wind_speed" => 1.34,
        "wind_deg" => 351,
        "wind_gust" => 3.58,
        "weather" => [
          {
            "id" => 801,
            "main" => "Clouds",
            "description" => "few clouds",
            "icon" => "02d"
          }
        ]
      },
     "hourly" => [
        {
          "dt" => 1610992800,
          "temp" => 275.09,
          "feels_like" => 271.71,
          "pressure" => 1018,
          "humidity" => 49,
          "dew_point" => 266.36,
          "uvi" => 1.83,
          "clouds" => 18,
          "visibility" => 10000,
          "wind_speed" => 0.74,
          "wind_deg" => 88,
          "weather" => [
            {
              "id" => 801,
               "main" => "Clouds",
               "description" => "few clouds",
               "icon" => "02d"
            }
          ],
          "pop" => 0
        }
      ],
      "daily" => [
        {
          "dt" => 1610996400,
          "sunrise" => 1610979458,
          "sunset" => 1611014575,
          "temp" => {
            "day" => 275.9,
            "min" => 271.18,
            "max" => 278.69,
            "night" => 271.18,
            "eve" => 275.2,
            "morn" => 273.06
          },
          "feels_like" => {
            "day" => 272.86,
            "night" => 267.38,
            "eve" => 268.13,
            "morn" => 270.41
          },
          "pressure" => 1018,
          "humidity" => 57,
          "dew_point" => 268.8,
          "wind_speed" => 0.63,
          "wind_deg" => 225,
          "weather" => [
            {
              "id" => 800,
              "main" => "Clear",
              "description" => "clear sky", "icon" => "01d"
            }
          ],
          "clouds" => 9,
          "pop" => 0.23,
          "uvi" => 1.96
        }
      ]
    }

    @forecast = Forecast.new(forecast_info)
  end

  describe 'Instance Methods' do
    describe '#format_current_weather' do
      it 'formats the current weather' do
        current_weather_info = {
          "dt" => 1610994697,
          "sunrise" => 1610979458,
          "sunset" => 1611014575,
          "temp" => 275.09,
          "feels_like" => 271.29,
          "pressure" => 1018,
          "humidity" => 49,
          "dew_point" => 266.36,
          "uvi" => 1.96,
          "clouds" => 18,
          "visibility" => 10000,
          "wind_speed" => 1.34,
          "wind_deg" => 351,
          "wind_gust" => 3.58,
          "weather" => [
            {
              "id" => 801,
              "main" => "Clouds",
              "description" => "few clouds",
              "icon" => "02d"
            }
          ]
        }

        expected = {
          datetime: "2021-01-18 10:31:37 -0800",
          sunrise: "2021-01-18 06:17:38 -0800",
          sunset: "2021-01-18 16:02:55 -0800",
          temperature: 33.94,
          feels_like: 30.14,
          humidity: 49,
          uvi: 1.96,
          visibility: 10000,
          conditions: "few clouds",
          icon: "02d"
        }

        expect(@forecast.format_current_weather(current_weather_info)).to eq(expected)
      end
    end

    describe '#format_daily_weather' do
      it 'formats daily weather' do
        one_day_weather_info = {
          "dt" => 1610996400,
          "sunrise" => 1610979458,
          "sunset" => 1611014575,
          "temp" => {
            "day" => 275.9,
            "min" => 271.18,
            "max" => 278.69,
            "night" => 271.18,
            "eve" => 275.2,
            "morn" => 273.06},
          "feels_like" => {
            "day" => 272.86,
            "night" => 267.38,
            "eve" => 268.13,
            "morn" => 270.41
          },
          "pressure" => 1018,
          "humidity" => 57,
          "dew_point" => 268.8,
          "wind_speed" => 0.63,
          "wind_deg" => 225,
          "weather" => [
            {
              "id" => 800,
              "main" => "Clear",
              "description" => "clear sky",
              "icon" => "01d"
            }
          ],
          "clouds" => 9,
          "pop" => 0.23,
          "uvi" => 1.96
        }
        daily_weather_info = []
        8.times do
          daily_weather_info << one_day_weather_info
        end

        expected_single_day = {
          date: "2021-01-18",
          sunrise: "2021-01-18 06:17:38 -0800",
          sunset: "2021-01-18 16:02:55 -0800",
          max_temp: 37.54,
          min_temp: 30.03,
          conditions: "clear sky",
          icon: "01d"
        }
        actual = @forecast.format_daily_weather(daily_weather_info)
        expect(actual.count).to eq(5)
        expect(actual.first).to eq(expected_single_day)
      end
    end

    describe '#format_hourly_weather' do
      it 'formats hourly weather' do
        one_hour_weather_info = {
          "dt" => 1610992800,
          "temp" => 275.09,
          "feels_like" => 271.71,
          "pressure" => 1018,
          "humidity" => 49,
          "dew_point" => 266.36,
          "uvi" => 1.83,
          "clouds" => 18,
          "visibility" => 10000,
          "wind_speed" => 0.74,
          "wind_deg" => 88,
          "weather" => [
            {
              "id" => 801,
              "main" => "Clouds",
              "description" => "few clouds",
              "icon" => "02d"
            }
          ],
          "pop" => 0
        }
        hourly_weather_info = []
        12.times do
          hourly_weather_info << one_hour_weather_info
        end

        expected_single_hour = {
          time: "10:00:00",
          temperature: 33.94,
          wind_speed: "0.74 mph",
          wind_direction: "Easterly",
          conditions: "few clouds",
          icon: "02d"
        }
        actual = @forecast.format_hourly_weather(hourly_weather_info)
        expect(actual.count).to eq(8)
        expect(actual.first).to eq(expected_single_hour)
      end
    end

    describe '#convert_to_wind_direction' do
      it 'takes degrees and turns it into a direction string' do
        expect(@forecast.convert_to_wind_direction(23)).to eq('North Easterly')
        expect(@forecast.convert_to_wind_direction(68)).to eq('Easterly')
        expect(@forecast.convert_to_wind_direction(123)).to eq('South Easterly')
        expect(@forecast.convert_to_wind_direction(158)).to eq('Southerly')
        expect(@forecast.convert_to_wind_direction(203)).to eq('South Westerly')
        expect(@forecast.convert_to_wind_direction(248)).to eq('Westerly')
        expect(@forecast.convert_to_wind_direction(293)).to eq('North Westerly')
        expect(@forecast.convert_to_wind_direction(0)).to eq('Northerly')
      end
    end

    describe '#convert_kelvin_to_fahrenheit' do
      it 'converts kelvin to F' do
        expect(@forecast.convert_kelvin_to_fahrenheit(364)).to eq(122.85)
      end
    end
  end
end
