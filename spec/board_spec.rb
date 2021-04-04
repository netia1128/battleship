require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/board_generator'

RSpec.describe Board do
  before do
    @board_dimension = 4
    @board_generator = BoardGenerator.new(@board_dimension)
    @board = Board.new(@board_generator.make_board_hash, @board_dimension)
    # @board = Board.new(board_hash, board_dimension)
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
  describe '#valid_placement' do
    it 'returns false if array provided is != to ship.length' do
      expect(@board.valid_placement?(["A1", "B1"], @cruiser)).to eq(false)
    end
    it 'returns false duplicate coordinates provided' do
      expect(@board.valid_placement?(["A1", "A1"], @submarine)).to eq(false)
    end
    it 'returns false if coordinates are not consecutive' do
      expect(@board.valid_placement?(["A1", "A3", "A4"], @cruiser)).to eq(false)
    end
    it 'returns false if coordinates are diagonal' do
      expect(@board.valid_placement?(["A1", "B2", "C3"], @cruiser)).to eq(false)
    end
    it 'returns false if cell is not empty' do
      @board.cells[:A1].place_ship(@tug_boat)
      expect(@board.valid_placement?(["A1", "B2", "C3"], @cruiser)).to eq(false)
    end
    it 'returns true if valid placement' do
      expect(@board.valid_placement?(["A1", "B1", "C1"], @cruiser)).to eq(true)
      expect(@board.valid_placement?(["D4", "C4"], @submarine)).to eq(true)
    end
  end
  describe '#is_consecutive?' do
    it 'returns true if the coordinates are horizontal and consecutive' do
      expect(@board.is_consecutive?(["A1", "A2"], @submarine)).to eq(true)
    end
    it 'returns true if the coordinates are vertical and consecutive' do
      expect(@board.is_consecutive?(["A1", "B1"], @submarine)).to eq(true)
    end
    it 'returns false if the coordinates are vertical but not consecutive' do
      expect(@board.is_consecutive?(["A1", "C1"], @submarine)).to eq(false)
    end
    it 'returns false if the coordinates are horizontal but not consecutive' do
      expect(@board.is_consecutive?(["A1", "A3"], @submarine)).to eq(false)
    end
    it 'returns false if the coordinates aren\'t horizontal or vertical' do
      expect(@board.is_consecutive?(["A1", "D3"], @submarine)).to eq(false)
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
  describe '#coordinates_empty?' do
    it 'returns true if all cells are empty' do
      expect(@board.coordinates_empty?(["A1", "A2"])).to eq(true)
    end
    it 'returns false if any cells are not empty' do
      @board.place(["A1"], @tug_boat)
      expect(@board.coordinates_empty?(["A1", "A2"])).to eq(false)
    end
  end
  describe 'coordinates_match_ship_length?' do
    it 'returns false if the number of coordinates don\'t match ship length' do
      expect(@board.coordinates_match_ship_length?(["A1", "B1"], @cruiser)).to eq(false)
    end
    it 'returns true if the number of coordinates match ship length' do
      expect(@board.coordinates_match_ship_length?(["A1", "B1"], @submarine)).to eq(true)
    end
  end
  describe '#place' do
    it 'does not update the status of a cell if coordinate is invalid' do
      @board.place(["A0", "A1", "A2"], @cruiser)
      expect(@board.cells[:A2].status).to eq(".")
    end
    it 'does not update the status of a cell if placement is invalid' do
      @board.place(["A4", "A1", "A2"], @cruiser)
      expect(@board.cells[:A2].status).to eq(".")
    end
    it 'does not update the cell\'s ship if coordinate is invalid' do
      @board.place(["A0", "A1", "A2"], @cruiser)
      expect(@board.cells[:A2].ship).to eq(nil)
    end
    it 'does not update the cell\'s ship if placement is invalid' do
      @board.place(["A4", "A1", "A2"], @cruiser)
      expect(@board.cells[:A2].ship).to eq(nil)
    end
    it 'updates the cell\'s ship to the placed ship' do
      @board.place(["A3", "A1", "A2"], @cruiser)
      expect(@board.cells[:A1].ship).to eq(@cruiser)
      expect(@board.cells[:A2].ship).to eq(@cruiser)
      expect(@board.cells[:A3].ship).to eq(@cruiser)
    end
    it 'updates the cell\'s ship to the placed ship' do
      @board.place(["A3", "A1", "A2"], @cruiser)
      expect(@board.cells[:A1].status).to eq("S")
      expect(@board.cells[:A2].status).to eq("S")
      expect(@board.cells[:A3].status).to eq("S")
    end
  end
  describe '#render' do
    it 'renders the starting board with all "."s' do
      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end
    it 'renders the board with ships hidden if show_ships = false' do
      @board.place(["A3", "A1", "A2"], @cruiser)
      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end
    it 'renders the board with ships shown if show_ships = true' do
      @board.place(["A3", "A1", "A2"], @cruiser)
      expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end
    it 'renders the board with M where applicable' do
      @board.cells[:A4].fire_upon
      expect(@board.render).to eq("  1 2 3 4 \nA . . . M \nB . . . . \nC . . . . \nD . . . . \n")
    end
    it 'renders the board with H where applicable' do
      @board.place(["A3", "A1", "A2"], @cruiser)
      @board.cells[:A1].fire_upon
      expect(@board.render).to eq("  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end
    it 'renders the board with X where applicable' do
      @board.place(["A3", "A1", "A2"], @cruiser)
      @board.cells[:A1].fire_upon
      @board.cells[:A2].fire_upon
      @board.cells[:A3].fire_upon
      expect(@board.render(true)).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  end
end
