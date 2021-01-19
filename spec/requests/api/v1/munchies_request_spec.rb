require 'rails_helper'

describe 'Munchies API' do
  it 'gets destination city info including ETA, open Chinese restaurant, and forecast' do
    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'

    expect(response).to be_successful
    response_body = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response_body).to be_a(Hash)
    expect(response_body[:attributes][:destination_city]).to be_a(String)
    expect(response_body[:attributes][:travel_time]).to be_a(String)
    expect(response_body[:attributes][:forecast]).to be_a(Hash)
    expect(response_body[:attributes][:restaurant]).to be_a(Hash)

    expect(response_body[:id]).to be nil
    expect(response_body[:type]).to be_a(String)
    expect(response_body.keys).to eq([:id, :type, :attributes])
    expect(response_body[:attributes].keys).to eq([:destination_city, :travel_time, :forecast, :restaurant])

    expected_forecast_keys = [
      :summary,
      :temperature
    ]

    expect(response_body[:attributes][:forecast].keys).to eq(expected_forecast_keys)
    expect(response_body[:attributes][:forecast][:summary]).to be_a(String)
    expect(response_body[:attributes][:forecast][:temperature]).to be_a(String)

    expected_restaurant_keys = [
      :name,
      :address
    ]

    expect(response_body[:attributes][:restaurant].keys).to eq(expected_restaurant_keys)
    expect(response_body[:attributes][:restaurant][:name]).to be_a(String)
    expect(response_body[:attributes][:restaurant][:address]).to be_a(String)
  end
end
