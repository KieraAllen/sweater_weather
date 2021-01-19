require 'rails_helper'

describe MapquestService do
  describe 'Instance Methods' do
    describe 'get_coordinates' do
      it 'uses location to get coordinates' do
        service = MapquestService.new('Denver, CO')

        expected = {
          "lat" => 39.738453,
          "lng" => -104.984853
        }

        expect(service.get_coordinates).to eq(expected)
      end
    end
  end
end
