class Board
  attr_reader :cells,
              :shots_available
  def initialize(board_hash, board_dimension)
    @cells = board_hash
    @board_dimension = board_dimension
    @shots_available = @cells.keys
  end

  def valid_placement?(ship, coordinates)
    coordinates_match_ship_length?(coordinates, ship) &&
    no_duplicate_coordinates?(coordinates) &&
    coordinates_empty?(coordinates) &&
    is_consecutive?(coordinates, ship)
  end

  def is_consecutive?(coordinates, ship)
    if is_horizontal?(coordinates)
      return ((user_coordinate_numbers(coordinates).last - user_coordinate_numbers(coordinates).first) + 1 == ship.length)
    elsif is_vertical?(coordinates)
      return ((user_coordinate_letters(coordinates).last.ord - user_coordinate_letters(coordinates).first.ord) + 1 == ship.length)
    else
      return false
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.to_a.include? coordinate.to_sym
  end

  def coordinates_empty?(coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate.to_sym].empty?
    end
  end

  def coordinates_match_ship_length?(coordinates, ship)
    coordinates.count == ship.length
  end

  def no_duplicate_coordinates?(coordinates)
    coordinates.uniq.count == coordinates.length
  end

  def split_user_coordinates(coordinates)
    coordinates.map do |coordinate|
      coordinate.split("")
    end
  end

  def user_coordinate_numbers(coordinates)
    split_user_coordinates(coordinates).map do |sub_arr|
      sub_arr[1].to_i
    end.sort
  end

  def user_coordinate_letters(coordinates)
    split_user_coordinates(coordinates).map do |sub_arr|
      sub_arr[0]
    end.sort
  end

  def is_horizontal?(coordinates)
    user_coordinate_letters(coordinates).uniq.count == 1
  end

  def is_vertical?(coordinates)
    user_coordinate_numbers(coordinates).uniq.count == 1
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      if !valid_coordinate?(coordinate)
        # TODO call the error message here
        # exit or break or return with no value
          # look into ruby error raising if you want to be fancy
        return false
      end
    end
    if !valid_placement?(ship, coordinates)
      # TODO call the error message here
      # exit
      return false
    end
    coordinates.each do |coordinate|
      @cells[coordinate.to_sym].place_ship(ship)
    end
  end

  def render(show_ships = false)
    string = top_row
    @cells.each do |key, value|
      if key.to_s[1] == "1"
        string += "#{key.to_s[0]} #{value.render(show_ships)} "
      elsif key.to_s[1].to_i == board_dimension
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

  def board_dimension
    Math.sqrt(@cells.count).to_i
  end

  def board_numbers
    (1..board_dimension).to_a
  end
end
