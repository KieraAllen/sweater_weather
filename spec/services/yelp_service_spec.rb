require 'rails_helper'

describe YelpService do
  describe 'Instance Methods' do
    describe 'get_info' do
      it 'can get a restaurant' do
        service = YelpService.new

        expected_headers = [
          # 'lat',
          # 'lon',
          # 'timezone',
          # 'timezone_offset',
          # 'current',
          # 'hourly',
          # 'daily',
        ]

        expect(service.get_info('pueblo,co', 'chinese', '3:00 PM')).to be_a(Hash)
        expect(service.get_forecast.keys).to eq(expected_headers)
      end
    end
  end
end
