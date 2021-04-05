
require_relative 'evaluator'
require_relative 'board'
require_relative 'game'
require_relative 'ship'

class Player
  attr_reader :board,
              :ships,
              :last_shot_coordinate

### # QUESTION: is it worth putting IV in the attr_reader simply to be able to test them. Or is it worth making a helper method for this purpose?

  def initialize(board_dimension)
    @board_dimension = board_dimension
    @board = Board.new(@board_dimension)
    @evaluator = Evaluator.new(@board.cells)
    @shots_available = @board.make_board_array
    @ships = ShipGenerator.new.make_ships
    @last_shot_coordinate = ''
  end

  def computron_ship_placement
    ships.each do |ship|
      board.place(try(ship), ship)
    end
  end

  def try(ship)
    pivot_point = @shots_available.sample
    until @evaluator.coordinates_empty?([pivot_point], @board.cells)
      pivot_point = @shots_available.sample
    end
    pivot_point_index = @shots_available.index(pivot_point)
    movement_array = @evaluator.create_movement_array(pivot_point_index, @board_dimension)
    wip_array = [pivot_point]
    until board.place(wip_array, ship) != false && wip_array.include?(nil) == false
      wip_coordinate = pivot_point
      wip_coordinate_index =  pivot_point_index
      wip_array = [pivot_point]
      direction = movement_array.sample
      require 'pry'; binding.pry
      until wip_array.count == ship.length do

        if direction == nil || wip_coordinate_index == nil
          #THIS IS THE BUG
          require 'pry'; binding.pry
        end

        wip_coordinate_index += direction
        # if @shots_available[wip_coordinate_index] != nil
        wip_coordinate = @shots_available[wip_coordinate_index]
        wip_array << wip_coordinate
        # else reset wip array to pivot_point, change direction, and remove direction from movement_array?
      end
      movement_array.delete(direction)
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
    else
        random_shot
    end
  end

  def random_shot
    @last_shot_coordinate = @shots_available.sample
    fire_upon(@last_shot_coordinate)
    @shots_available.delete @last_shot_coordinate
  end

  def smart_shot(hit_cells_arr)
    pivot_point = hit_cells_arr[0]
    cells = @board.make_board_array
    pivot_point_index = set_pivot_point_index(pivot_point)

    movement_array = @evaluator.create_movement_array(pivot_point_index, @board_dimension)
    direction = movement_array.sample

    proposed_shot_coordinate = cells[pivot_point_index + direction]

    until fire_upon(proposed_shot_coordinate) != false
      movement_array.delete(direction)
      direction = movement_array.sample
      if direction == nil
        pivot_point = hit_cells_arr[1]
        pivot_point_index = set_pivot_point_index(pivot_point)
        movement_array = @evaluator.create_movement_array(pivot_point_index, @board_dimension)
        direction = movement_array.sample
      end
      proposed_shot_coordinate = cells[pivot_point_index + direction]
    end

    fire_upon(proposed_shot_coordinate)
    @last_shot_coordinate = proposed_shot_coordinate
    @shots_available.delete proposed_shot_coordinate
  end

  def set_pivot_point_index(pivot_point)
    cells = @board.make_board_array
    pivot_point_index = cells.index(pivot_point)
    pivot_point_index
  end
end
