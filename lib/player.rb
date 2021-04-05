require_relative 'board_generator'
require_relative 'board'
require_relative 'game'
require_relative 'ship'

class Player
  attr_reader :board_generator,
              :board,
              :ships,
              :name,
              :last_shot_coordinate

### # QUESTION: is it worth putting IV in the attr_reader simply to be able to test them. Or is it worth making a helper method for this purpose?

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
    @last_shot_coordinate = ''
  end

  def computron_ship_placement
    ships.each do |ship|
      board.place(try(ship), ship)
    end
  end

  def try(ship)
    original_coordinate = @shots_available.sample
    until @board.coordinates_empty?([original_coordinate])
      original_coordinate = @shots_available.sample
    end

    original_coordinate_index = @shots_available.index(original_coordinate)
    movement_variable = [1, @board_dimension, -1, (@board_dimension * -1)]
    wip_array = [original_coordinate]

    until board.place(wip_array, ship) != false
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

  def fire_upon(shot_coordinate)
    if @board.valid_coordinate?(shot_coordinate)
      if !@board.cells[shot_coordinate.to_sym].fired_upon?
        @board.cells[shot_coordinate.to_sym].fire_upon
      else
        return false
      end
    else
      return false
    end
  end

  def auto_shot_selection(difficulty = "easy")
    hit_cells_arr = @board.make_hit_cells_arr
    if difficulty == "hard" && hit_cells_arr.count > 0
        smart_shot(hit_cells_arr)
        puts hit_cells_arr
    else
        random_shot
    end

      # # last_shot_coordinate needs an actual cell to evaluate this if statement
      # if @last_shot_coordinate == "" || !@board.cells[@last_shot_coordinate.to_sym].status == "H"
      #   random_shot
      # elsif @board.cells[@last_shot_coordinate.to_sym].status == "H"
      #   smart_shot
      #   # check board cells for status = H and make array
      #   # set last_shot_coordinate = array.first and re-enter smart_shot
      # else
      #   random_shot
    #   end
    # end
  end

  def random_shot
    @last_shot_coordinate = @shots_available.sample
    fire_upon(@last_shot_coordinate)
    @shots_available.delete @last_shot_coordinate
  end

  def smart_shot(hit_cells_arr)
    pivot_point = hit_cells_arr[0]
    pivot_point_index = @board_generator.board_array.index(pivot_point)
    movement_array = [1, -1, @board_dimension, (@board_dimension * -1)]
    until  fire_upon(@last_shot_coordinate) != false
      direction = movement_array.sample
      @last_shot_coordinate = @board_generator.board_array[pivot_point_index + direction]
      puts "My movement direction is #{direction}
      movement_array.delete(direction)
      puts "my hits array is #{hit_cells_arr}"
      puts "I am looking at #{@last_shot_coordinate}"
      gets
    end
    fire_upon(@last_shot_coordinate)
    @shots_available.delete @last_shot_coordinate
  end

  # def smart_shot
  #   pivot_point = @last_shot_coordinate
  #   until @board.cells.[@last_shot_coordinate.to_sym].status = "X"
  #     # - find the index of pivot_point within @board_generator.board_array.
  #     # - increment by an element of this array:
  #     #   [1, -1, board_dimension, -board_dimension]
  #         # keep this element unchanged so we can either continue looking that
  #         # many cells away. If next shot is M or coordinate is not valid,
  #         # reverse (element * -1) if possible)
  #     # - see if this new coordinate is valid_coordinate && empty
  #     # - fire and change the index by adding by an element of this array:
  #     #   [1, -1, board_dimension, -board_dimension]
  #     # - put bullet into chamber to be re-evaluated by until loop?
  #     #   until array is empty?
  #   end
  #   # check board cells for status = H and make array
  #   # set pivot_point = array.first and re-enter until loop
  # end


end
