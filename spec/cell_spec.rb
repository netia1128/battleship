require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before do
    @cell = Cell.new("B4")
  end

  describe '#initialize' do
    it 'creates an instance of a cell' do
      expect(@cell).to be_an_instance_of(Cell)
    end

    it 'has a coordinate' do
      expect(@cell.coordinate).to eq("B4")
    end

    it 'has a . status' do
      expect(@cell.status).to eq(".")
    end

    it 'does not start with a ship' do
      expect(@cell.ship).to eq(nil)
    end
  end

  describe '#empty?' do
    it 'tells me if a cell is empty' do
      expect(@cell.empty?).to eq(true)
    end
  end

  describe '#place ship' do
    it 'places a ship' do
      @cell.place_ship
      expect(@cell.status).to eq('S')
    end
  end

end
