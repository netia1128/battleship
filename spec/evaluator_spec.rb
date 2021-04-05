require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Evaluator do

  before do
    @board_dimension = 4
    @board = Board.new(@board_dimension)
    @evaluator = @board.evaluator
    @cruiser = Ship.new("Cruiser", 3)
    @tug_boat = Ship.new("Tug Boat", 1)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#initialize' do
    it 'creates an instance of an Evaluator' do
      expect(@evaluator).to be_an_instance_of(Evaluator)
    end
  end
  describe '#is_consecutive?' do
    it 'returns true if the coordinates are horizontal and consecutive' do
      expect(@evaluator.is_consecutive?(["A1", "A2"], @submarine)).to eq(true)
    end
    it 'returns true if the coordinates are vertical and consecutive' do
      expect(@evaluator.is_consecutive?(["A1", "B1"], @submarine)).to eq(true)
    end
    it 'returns false if the coordinates are vertical but not consecutive' do
      expect(@evaluator.is_consecutive?(["A1", "C1"], @submarine)).to eq(false)
    end
    it 'returns false if the coordinates are horizontal but not consecutive' do
      expect(@evaluator.is_consecutive?(["A1", "A3"], @submarine)).to eq(false)
    end
    it 'returns false if the coordinates aren\'t horizontal or vertical' do
      expect(@evaluator.is_consecutive?(["A1", "D3"], @submarine)).to eq(false)
    end
  end
  describe 'coordinates_match_ship_length?' do
    it 'returns false if the number of coordinates don\'t match ship length' do
      expect(@evaluator.coordinates_match_ship_length?(["A1", "B1"], @cruiser)).to eq(false)
    end
    it 'returns true if the number of coordinates match ship length' do
      expect(@evaluator.coordinates_match_ship_length?(["A1", "B1"], @submarine)).to eq(true)
    end
  end
  describe '#coordinates_empty?' do
    it 'returns true if all cells are empty' do
      expect(@evaluator.coordinates_empty?(["A1", "A2"], @board.cells)).to eq(true)
    end
    it 'returns false if any cells are not empty' do
      @board.place(["A1"], @tug_boat)
      expect(@evaluator.coordinates_empty?(["A1", "A2"], @board.cells)).to eq(false)
    end
  end
end
