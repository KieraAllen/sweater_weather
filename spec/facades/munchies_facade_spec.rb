require 'rails_helper'

describe MunchiesFacade do
  describe 'Instance Methods' do
    describe '#munchies' do
      it 'uses services to create destination info' do
        info = {
          start: "denver,co",
          end_location: "pueblo,co",
          food: "chinese"
        }

        facade = MunchiesFacade.new(info)

        actual = facade.munchies
        expect(actual).to be_a(Munchies)
        expect(actual.id).to be nil
      end
    end
  end
end
