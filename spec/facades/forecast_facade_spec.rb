require 'rails_helper'

describe ForecastFacade do
  describe 'Instance Methods' do
    describe '#forecast' do
      it 'uses services to create a forecast' do
        facade = ForecastFacade.new('Denver, CO')

        actual = facade.forecast
        expect(actual).to be_a(Forecast)
        expect(actual.id).to be nil
      end
    end
  end
end
