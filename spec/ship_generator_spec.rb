require './lib/ship_generator'
require './lib/ship'


RSpec.describe ShipGenerator do

  before do
    @ship_generator = ShipGenerator.new
  end

  describe '#initialize' do
    it 'starts with a blank ships array' do
      expect(@ship_generator.ships).to eq([])
    end
  end
  describe '#make_ships' do
    it 'makes three ships' do
      @ship_generator.make_ships
      expect(@ship_generator.ships.count).to eq(3)
    end
    it 'contains ships' do
      @ship_generator.make_ships
      expect(@ship_generator.ships[0]).to be_an_instance_of(Ship)
    end
  end
end
