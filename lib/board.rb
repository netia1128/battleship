require_relative 'evaluator'

class Board
  attr_reader :cells

  def initialize(board_hash, board_dimension)
    @cells = board_hash
    @board_dimension = board_dimension
    @evaluator = Evaluator.new
  end

  def valid_placement?(coordinates, ship)
    @evaluator.coordinates_match_ship_length?(coordinates, ship) &&
    @evaluator.no_duplicate_coordinates?(coordinates) &&
    coordinates_empty?(coordinates) &&
    @evaluator.is_consecutive?(coordinates, ship)
  end

  def place(coordinates, ship)
    coordinates.each do |coordinate|
      if !valid_coordinate?(coordinate)
        return false
      end
    end
    if !valid_placement?(coordinates, ship)
      return false
    end
    coordinates.each do |coordinate|
      @cells[coordinate.to_sym].place_ship(ship)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.to_a.include? coordinate.to_sym
  end

  def coordinates_empty?(coordinates)
    coordinates.all? do |coordinate|
      @cells[coordinate.to_sym].empty?
    end
  end



  def render(show_ships = false)
    string = top_row
    @cells.each do |key, value|
      if key.to_s[1] == "1"
        string += "#{key.to_s[0]} #{value.render(show_ships)} "
      elsif key.to_s[1].to_i == @board_dimension
        string += "#{value.render(show_ships)} \n"
      else
       string += "#{value.render(show_ships)} "
      end
    end
    string
  end

  def top_row
    return "  #{board_numbers.join(' ')} \n"
  end

  def board_numbers
    (1..@board_dimension).to_a
  end

  def make_hit_cells_arr
    hit_cells_arr = []
    @cells.each do |key, value|
        if @cells[key].render == "H"
          hit_cells_arr << cells[key].coordinate
      end
    end
    hit_cells_arr
  end
end
