require_relative 'ship'
require_relative 'board_generator'
require_relative 'board'

class Player
  attr_reader :board_generator,
              :board,
              :ships

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
    # require 'pry'; binding.pry

    proposed_coordinate = @shots_available.sample

    if board.place(@ships[0], try_right(proposed_coordinate)) == false
      puts @board.render(true)
    end
      #try left and if false
        #try up if false
          #try down false

    #try to place it
    # puts board.place(@ships[0], proposed_array)
    # puts proposed_array
    # puts @board.render(true)
  end

  def try_right(proposed_coordinate)
        # require 'pry'; binding.pry
    proposed_coordinate_index =  @shots_available.index(proposed_coordinate)
    proposed_array = [proposed_coordinate]

    until proposed_array.count == @ships[0].length do
      proposed_coordinate_index +=1
      proposed_coordinate = @shots_available[proposed_coordinate_index]
      proposed_array << proposed_coordinate
    end
    puts proposed_array
    proposed_array
  end

end
