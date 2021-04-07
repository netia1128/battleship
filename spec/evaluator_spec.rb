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
  describe '#coordinates_match_ship_length?' do
    it 'returns false if the number of coordinates don\'t match ship length' do
      expect(@evaluator.coordinates_match_ship_length?(["A1", "B1"], @cruiser)).to eq(false)
    end
    it 'returns true if the number of coordinates match ship length' do
      expect(@evaluator.coordinates_match_ship_length?(["A1", "B1"], @submarine)).to eq(true)
    end
  end
  describe '#no_duplicate_coordinates' do
    it 'returns false if there are duplicate coordinates' do
      expect(@evaluator.no_duplicate_coordinates?(["A1", "A1"])).to eq(false)
    end
    it 'returns true if there are duplicate coordinates' do
      expect(@evaluator.no_duplicate_coordinates?(["A1", "A2"])).to eq(true)
    end
  end
  describe '#split_user_coordinates' do
    it 'creates an array of arrays containing letter and number pairs' do
      expect(@evaluator.split_user_coordinates(["A1", "A2", "A3"])).to eq([["A", "1"], ["A", "2"], ["A", "3"]])
    end
  end
  describe '#user_coordinate_numbers' do
    it 'creates an array of all the number portions of the user\'s coordinates' do
      expect(@evaluator.user_coordinate_numbers(["A1", "A2", "A3"])).to eq([1, 2, 3])
    end
  end
  describe '#user_coordinate_letters' do
    it 'creates an array of all the number portions of the user\'s coordinates' do
      expect(@evaluator.user_coordinate_letters(["A1", "A2", "A3"])).to eq(["A", "A", "A"])
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
  describe '#is_horizontal?' do
    it 'returns false if at least one coordinates is not horizontal with all other coordinates' do
      expect(@evaluator.is_horizontal?(["A1", "B2", "A3"])).to eq(false)
    end
    it 'returns true if all coordinates are horizontal' do
      expect(@evaluator.is_horizontal?(["A1", "A2", "A3"])).to eq(true)
    end
  end
  describe '#is_vertical?' do
    it 'returns false if at least one coordinates is not vertical with all other coordinates' do
      expect(@evaluator.is_vertical?(["A1", "B1", "A3"])).to eq(false)
    end
    it 'returns true if all coordinates are vertical' do
      expect(@evaluator.is_vertical?(["A1", "B1", "C1"])).to eq(true)
    end
  end
  describe '#is_horizontal_or_vertical?' do
    it 'returns false if at least one coordinates is not horizontal or vertical with all other coordinates' do
      expect(@evaluator.is_horizontal_or_vertical?(["A1", "B1", "A3"])).to eq(false)
    end
    it 'returns true if all coordinates are horizontal' do
      expect(@evaluator.is_horizontal_or_vertical?(["A1", "A2", "A4"])).to eq(true)
    end
    it 'returns true if all coordinates are vertical' do
      expect(@evaluator.is_horizontal_or_vertical?(["A1", "B1", "D1"])).to eq(true)
    end
  end
  describe '#vertical_start_row?' do
    it 'returns false if coordinate is not in the leftmost column' do
      expect(@evaluator.vertical_start_row?(5, 4)).to eq(false)
    end
    it 'returns true if coordinate is not in the leftmost column' do
      expect(@evaluator.vertical_start_row?(4, 4)).to eq(true)
    end
  end
  describe '#vertical_end_row?' do
    it 'returns false if coordinate is not in the rightmost column' do
      expect(@evaluator.vertical_end_row?(5, 4)).to eq(false)
    end
    it 'returns true if coordinate is not in the rightmost column' do
      expect(@evaluator.vertical_end_row?(7, 4)).to eq(true)
    end
  end
  describe '#horizontal_start_row?' do
    it 'returns false if coordinate is not in the top row' do
      expect(@evaluator.horizontal_start_row?(5, 4)).to eq(false)
    end
    it 'returns true if coordinate is not in the top row' do
      expect(@evaluator.horizontal_start_row?(2, 4)).to eq(true)
    end
  end
  describe '#horizontal_end_row?' do
    it 'returns false if coordinate is not in the bottom row' do
      expect(@evaluator.horizontal_end_row?(5, 4)).to eq(false)
    end
    it 'returns true if coordinate is not in the bottom row' do
      expect(@evaluator.horizontal_end_row?(14, 4)).to eq(true)
    end
  end
  describe '#create_movement_array' do
    it 'creates an array containing all numbers needed to move up, down, left, and right' do
      expect(@evaluator.create_movement_array(0, 4)).to eq([4, 1])
      expect(@evaluator.create_movement_array(2, 4)).to eq([4, -1, 1])
      expect(@evaluator.create_movement_array(3, 4)).to eq([4, -1])
      expect(@evaluator.create_movement_array(4, 4)).to eq([-4, 4, 1])
      expect(@evaluator.create_movement_array(5, 4)).to eq([-4, 4, -1, 1])
      expect(@evaluator.create_movement_array(7, 4)).to eq([-4, 4, -1])
      expect(@evaluator.create_movement_array(12, 4)).to eq([-4, 1])
      expect(@evaluator.create_movement_array(14, 4)).to eq([-4, -1, 1])
      expect(@evaluator.create_movement_array(15, 4)).to eq([-4, -1])
    end
  end
end
