require 'rails_helper'

describe UnsplashService do
  describe 'Instance Methods' do
    describe 'get_image' do
      it 'uses location to get an image' do
        service = UnsplashService.new('Denver, CO')

        expect(service.get_image).to be_a(Hash)
        expect(service.get_image[:results].first.keys).to include(:urls, :user)
      end
    end
  end
end
