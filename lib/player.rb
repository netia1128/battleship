require_relative 'board_generator'
require_relative 'board'
require_relative 'ship'

class Player
  attr_reader :board_generator,
              :board,
              :ships,
              :name

  def initialize(name, board_dimension)
    @name = name
    @board_generator = BoardGenerator.new(board_dimension)
    @board_dimension = board_dimension
    @shots_available = @board_generator.board_array
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @tug_boat = Ship.new("Tug Boat", 1)
    @ships = [@cruiser, @submarine, @tug_boat]
    #would you like this to be a helper method?
    @board = Board.new(@board_generator.make_board_hash, @board_dimension)
  end

  # def make_board
  #   @board = Board.new(@board_generator.make_board_hash, @board_dimension)
  # end

  def computron_placement
    ships.each do |ship|
      board.place(ship, try(ship))
    end
  end

  def try(ship)
    # original_coordinate = @shots_available.sample
    original_coordinate = "A1"
    until @board.coordinates_empty?([original_coordinate])
      original_coordinate = @shots_available.sample
    end

    original_coordinate_index = @shots_available.index(original_coordinate)
    movement_variable = [1, @board_dimension, -1, (@board_dimension * -1)]
    wip_array = [original_coordinate]

    until board.place(ship, wip_array) != false
      wip_coordinate = original_coordinate
      wip_coordinate_index =  original_coordinate_index
      wip_array = [original_coordinate]
      wip_movement_variable = movement_variable.sample
      until wip_array.count == ship.length do
        wip_coordinate_index += wip_movement_variable
        wip_coordinate = @shots_available[wip_coordinate_index]
        wip_array << wip_coordinate
      end
      movement_variable.delete(wip_movement_variable)
    end

    wip_array
  end

end
