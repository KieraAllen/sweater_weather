require 'rails_helper'

describe OpenweatherService do
  describe 'Instance Methods' do
    describe 'get_forecast' do
      it 'uses coordinates to get forecast' do
        coordinates = {
          "lat" => 39.738453,
          "lng" => -104.984853
        }

        service = OpenweatherService.new(coordinates)

        expected_headers = [
          'lat',
          'lon',
          'timezone',
          'timezone_offset',
          'current',
          'hourly',
          'daily',
        ]

        expect(service.get_forecast).to be_a(Hash)
        expect(service.get_forecast.keys).to eq(expected_headers)
      end
    end
  end
end
