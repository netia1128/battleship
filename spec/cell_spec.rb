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
    it 'returns true if a cell is empty' do
      expect(@cell.empty?).to eq(true)
    end
    it 'returns false if a cell is not empty' do
      ship = Ship.new("cruiser", 3)
      @cell.place_ship(ship)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe '#place ship' do
    it 'places a ship' do
      ship = Ship.new("cruiser", 3)
      @cell.place_ship(ship)
      expect(@cell.status).to eq('S')
    end
  end

  describe '#fired_upon?' do
    it 'returns false if cell has not been fired upon' do
      expect(@cell.fired_upon?).to eq(false)
      ship = Ship.new("cruiser", 3)
      @cell.place_ship(ship)
      expect(@cell.fired_upon?).to eq(false)
    end
    it 'returns true if status is M' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end
    it 'returns true if status is H' do
      ship = Ship.new("cruiser", 3)
      @cell.place_ship(ship)
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end
    it 'returns true if status is X' do
      ship = Ship.new("tug boat", 1)
      @cell.place_ship(ship)
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe '#fire_upon' do
    describe 'updates status' do
      it 'from . to M' do
        @cell.fire_upon
        expect(@cell.status).to eq("M")
      end
      it 'from S to H' do
        ship = Ship.new("cruiser", 3)
        @cell.place_ship(ship)
        @cell.fire_upon
        expect(@cell.status).to eq("H")
      end
      it 'from S to X' do
        ship = Ship.new("tug boat", 1)
        @cell.place_ship(ship)
        @cell.fire_upon
        expect(@cell.status).to eq("X")
      end
    end

    describe '#render' do
        it 'renders a cell with . status as .' do
          expect(@cell.render).to eq(".")
        end
        it 'renders a cell with M status as M' do
          @cell.fire_upon
          expect(@cell.render).to eq("M")
        end
        it 'renders a cell with S status as . by default' do
          ship = Ship.new("tug boat", 1)
          @cell.place_ship(ship)
          expect(@cell.render).to eq(".")
        end
        it 'renders a cell with S status as .' do
          ship = Ship.new("tug boat", 1)
          @cell.place_ship(ship)
          expect(@cell.render(true)).to eq(".")
        end
      end
  end

end
