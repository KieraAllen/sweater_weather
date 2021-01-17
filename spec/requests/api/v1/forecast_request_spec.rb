require 'rails_helper'

describe 'Forecast API' do
  it 'gets weather for a city' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    response_body = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response_body).to be_a(Hash)
    expect(response_body[:attributes][:current_weather]).to be_a(Hash)
    expect(response_body[:attributes][:daily_weather]).to be_a(Array)
    expect(response_body[:attributes][:hourly_weather]).to be_a(Array)

    expect(response_body[:type]).to be_a(String)
    expect(response_body[:id]).to be nil
    expect(response_body.keys).to eq([:id, :type, :attributes])
    expect(response_body[:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])

    expected_current_weather_keys = [
      :datetime,
      :sunrise,
      :sunset,
      :temperature,
      :feels_like,
      :humidity,
      :uvi,
      :visibility,
      :conditions,
      :icon
    ]

    expect(response_body[:attributes][:current_weather].keys).to eq(expected_current_weather_keys)

    expect(response_body[:attributes][:current_weather][:datetime]).to be_a(String)
    expect(response_body[:attributes][:current_weather][:sunrise]).to be_a(String)
    expect(response_body[:attributes][:current_weather][:sunset]).to be_a(String)
    expect(response_body[:attributes][:current_weather][:temperature]).to be_a(Float)
    expect(response_body[:attributes][:current_weather][:feels_like]).to be_a(Float)
    expect(response_body[:attributes][:current_weather][:humidity].class).to be_in([Float, Integer])
    expect(response_body[:attributes][:current_weather][:uvi].class).to be_in([Float, Integer])
    expect(response_body[:attributes][:current_weather][:visibility].class).to be_in([Float, Integer])
    expect(response_body[:attributes][:current_weather][:conditions]).to be_a(String)
    expect(response_body[:attributes][:current_weather][:icon]).to be_a(String)

    expected_daily_weather_keys = [
      :date,
      :sunrise,
      :sunset,
      :max_temp,
      :min_temp,
      :conditions,
      :icon
    ]

    expect(response_body[:attributes][:daily_weather].count).to eq(5)
    expect(response_body[:attributes][:daily_weather].first.keys).to eq(expected_daily_weather_keys)

    expect(response_body[:attributes][:daily_weather].first[:date]).to be_a(String)
    expect(response_body[:attributes][:daily_weather].first[:sunrise]).to be_a(String)
    expect(response_body[:attributes][:daily_weather].first[:sunset]).to be_a(String)
    expect(response_body[:attributes][:daily_weather].first[:max_temp]).to be_a(Float)
    expect(response_body[:attributes][:daily_weather].first[:min_temp]).to be_a(Float)
    expect(response_body[:attributes][:daily_weather].first[:conditions]).to be_a(String)
    expect(response_body[:attributes][:daily_weather].first[:icon]).to be_a(String)

    expected_hourly_weather_keys = [
      :time,
      :temperature,
      :wind_speed,
      :wind_direction,
      :conditions,
      :icon
    ]

    expect(response_body[:attributes][:hourly_weather].count).to eq(8)
    expect(response_body[:attributes][:hourly_weather].first.keys).to eq(expected_hourly_weather_keys)

    expect(response_body[:attributes][:hourly_weather].first[:time]).to be_a(String)
    expect(response_body[:attributes][:hourly_weather].first[:temperature]).to be_a(Float)
    expect(response_body[:attributes][:hourly_weather].first[:wind_speed]).to be_a(String)
    expect(response_body[:attributes][:hourly_weather].first[:wind_direction]).to be_a(String)
    expect(response_body[:attributes][:hourly_weather].first[:conditions]).to be_a(String)
    expect(response_body[:attributes][:hourly_weather].first[:icon]).to be_a(String)
  end
end
