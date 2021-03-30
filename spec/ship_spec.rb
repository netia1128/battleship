require './lib/ship'

RSpec.describe Ship do
  before do
    @ship = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'creates an instance of a ship' do
      expect(@ship).to be_an_instance_of(Ship)
    end
    it 'has a name' do
      expect(@ship.name).to eq("Cruiser")
    end
    it 'has a length' do
      expect(@ship.length).to eq(3)
    end
    it 'has an initial health' do
      expect(@ship.health).to eq(3)
    end
  end
  describe '#sunk?' do
    it 'returns false if ship is not sunk' do
      expect(@ship.sunk?).to eq(false)
    end
    it 'returns true if ship is sunk' do
      @ship.hit
      @ship.hit
      @ship.hit
      expect(@ship.sunk?).to eq(true)
    end
  end
  describe '#hit' do
    it 'decrements health' do
      @ship.hit
      expect(@ship.health).to eq(2)
    end
  end
end
