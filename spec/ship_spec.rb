require './lib/ship'

RSpec.describe Ship do
  before do
    @ship = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'creates an instance of a ship' do
      expect(@ship).to be_an_instance_of(Ship)
    end
  end
end
