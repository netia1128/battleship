require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @tug_boat = Ship.new("Tug Boat", 1)
  end

  describe '#initialize' do
    it 'creates an instance of a board' do
      expect(@board).to be_an_instance_of(Board)
    end
    it 'has a grid of cells by default' do
      expect(@board.cells).to be_an_instance_of(Hash)
    end
    it 'has 16 cells by default' do
      expect(@board.cells.keys.count).to eq(16)
    end
    it 'has a hash of 16 instances of cells' do
      expect(@board.cells.values[0]).to be_an_instance_of(Cell)
    end
    it 'has an array of available shots' do
      expect(@board.shots_available).to eq([:A1, :A2, :A3, :A4, :B1, :B2, :B3, :B4, :C1, :C2, :C3, :C4, :D1, :D2, :D3, :D4])
    end
  end
end
