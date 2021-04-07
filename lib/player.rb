require_relative 'ship_generator'
require_relative 'evaluator'
require_relative 'board'
require_relative 'ship'

class Player
  attr_reader :board,
              :ships,
              :last_shot_coordinate,
              :shots_available

  def initialize(board_dimension)
    @board_dimension = board_dimension
    @board = Board.new(@board_dimension)
    @evaluator = Evaluator.new(@board.cells)
    @shots_available = @board.make_board_array
    @ships = ShipGenerator.new.make_ships
    @last_shot_coordinate = ''
  end

  def attempt_auto_ship_placement(ship)
    pivot_point = set_random_pivot_point
    pivot_point_index = set_pivot_point_index(pivot_point)
    movement_array = @evaluator.create_movement_array(pivot_point_index, @board_dimension)
    wip_array = [pivot_point]
    until board.place(wip_array, ship) && wip_array.include?(nil) == false
      direction = set_direction(movement_array)
      proposed_coordinate = pivot_point
      proposed_coordinate_index = pivot_point_index
      wip_array = [proposed_coordinate]
      until wip_array.count == ship.length do
        # require 'pry'; binding.pry
        proposed_coordinate_index = update_proposed_coordinate_index(proposed_coordinate_index, direction)
        proposed_coordinate = update_proposed_coordinate(proposed_coordinate_index)
        wip_array << proposed_coordinate
      end
      movement_array.delete(direction)
    end
    wip_array
  end

  def auto_ship_placement
    ships.each do |ship|
      board.place(attempt_auto_ship_placement(ship), ship)
    end
  end

  def auto_shot_selection(difficulty = "EASY")
    hit_cells_arr = @board.make_hit_cells_arr
    if difficulty == "HARD" && hit_cells_arr.count > 0
        smart_shot(hit_cells_arr)
    else
        random_shot
    end
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

  def random_shot
    @last_shot_coordinate = @shots_available.sample
    fire_upon(@last_shot_coordinate)
    @shots_available.delete @last_shot_coordinate
  end

  def set_direction(movement_array)
    movement_array.sample
  end

  def set_pivot_point_index(pivot_point)
    cells = @board.make_board_array
    cells.index(pivot_point)
  end

  def set_random_pivot_point
      pivot_point = @shots_available.sample
    until @evaluator.coordinates_empty?([pivot_point], @board.cells)
      pivot_point = @shots_available.sample
    end
    pivot_point
  end

  def set_wip_array(pivot_point)
    [pivot_point]
  end

  def smart_shot(hit_cells_arr)
    cells = @board.make_board_array
    pivot_point = hit_cells_arr[0]
    pivot_point_index = set_pivot_point_index(pivot_point)
    movement_array = @evaluator.create_movement_array(pivot_point_index, @board_dimension)
    direction = set_direction(movement_array)
    proposed_coordinate = cells[pivot_point_index + direction]
    until fire_upon(proposed_coordinate)
      movement_array.delete(direction)
      direction = set_direction(movement_array)
      movement_array[-1, 4 -4]
      if direction == nil
        pivot_point = hit_cells_arr[1]
        pivot_point_index = set_pivot_point_index(pivot_point)
        movement_array = @evaluator.create_movement_array(pivot_point_index, @board_dimension)
        direction = set_direction(movement_array)
      end
      proposed_coordinate_index = update_proposed_coordinate_index(pivot_point_index, direction)
      proposed_coordinate = update_proposed_coordinate(proposed_coordinate_index)
    end
    fire_upon(proposed_coordinate)
    @last_shot_coordinate = proposed_coordinate
    @shots_available.delete(proposed_coordinate)
  end

  def update_proposed_coordinate_index(proposed_coordinate_index, direction)
    proposed_coordinate_index += direction
  end

  def update_proposed_coordinate(proposed_coordinate_index)
    proposed_coordinate = @board.make_board_array[proposed_coordinate_index]
  end
end
