require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @tug_boat = Ship.new("Tug Boat", 1)
    @submarine = Ship.new("Submarine", 2)
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
  describe '#valid_coordinate?' do
    it 'returns true if coordinate on the board' do
      expect(@board.valid_coordinate?("B4")).to eq(true)
    end
    it 'returns false if coordinate on the board' do
      expect(@board.valid_coordinate?("F44")).to eq(false)
    end
  end
  describe '#valid_placement' do
    it 'returns false if array provided is != to ship.length' do
      expect(@board.valid_placement?(@cruiser,["A1", "B1"])).to eq(false)
    end
    it 'returns false duplicate coordinates provided' do
      expect(@board.valid_placement?(@submarine,["A1", "A1"])).to eq(false)
    end
    it 'returns false if coordinates are not consecutive' do
      expect(@board.valid_placement?(@cruiser,["A1", "A3", "A4"])).to eq(false)
    end
    it 'returns false if coordinates are diagonal' do
      expect(@board.valid_placement?(@cruiser,["A1", "B2", "C3"])).to eq(false)
    end
    it 'returns false if cell is not empty' do
      @board.cells[:A1].place_ship(@tug_boat)
      expect(@board.valid_placement?(@cruiser,["A1", "B2", "C3"])).to eq(false)
    end
    it 'returns true if valid placement' do
      expect(@board.valid_placement?(@cruiser,["A1", "B1", "C1"])).to eq(true)
      expect(@board.valid_placement?(@submarine,["D4", "C4"])).to eq(true)
    end
  end
  describe '#place' do
    it 'does not update the status of a cell if coordinate is invalid' do
      @board.place(@cruiser, ["A0", "A1", "A2"])
      expect(@board.cells[:A2].status).to eq(".")
    end
    it 'does not update the status of a cell if placement is invalid' do
      @board.place(@cruiser, ["A4", "A1", "A2"])
      expect(@board.cells[:A2].status).to eq(".")
    end
    it 'does not update the cells ship if coordinate is invalid' do
      @board.place(@cruiser, ["A0", "A1", "A2"])
      expect(@board.cells[:A2].ship).to eq(nil)
    end
    it 'does not update the cells ship if placement is invalid' do
      @board.place(@cruiser, ["A4", "A1", "A2"])
      expect(@board.cells[:A2].ship).to eq(nil)
    end
    # it 'updates the cells ship to the placed ship' do
    #
    # end
    # it 'updates the cells status from . to S' do
    #
    # end
  end
end
