class Board
  attr_reader :cells,
              :shots_available
  def initialize
    @cells = {
      :A1 => Cell.new("A1"),
      :A2 => Cell.new("A2"),
      :A3 => Cell.new("A3"),
      :A4 => Cell.new("A4"),
      :B1 => Cell.new("B1"),
      :B2 => Cell.new("B2"),
      :B3 => Cell.new("B3"),
      :B4 => Cell.new("B4"),
      :C1 => Cell.new("C1"),
      :C2 => Cell.new("C2"),
      :C3 => Cell.new("C3"),
      :C4 => Cell.new("C4"),
      :D1 => Cell.new("D1"),
      :D2 => Cell.new("D2"),
      :D3 => Cell.new("D3"),
      :D4 => Cell.new("D4")
    }
    @shots_available = @cells.keys
    # Should we remove the user_coordinates instance variable
    # or should we have a parameter throughout the class?
    @user_coordinates = []
    @proposed_ship = nil
  end

  # Should we take #coordinates_not_empty out of #valid_placement?
  def valid_placement?(ship, coordinates)
    @user_coordinates = coordinates
    @proposed_ship = ship
    # Does this burn your eyes?
    if coordinates_match_ship_length? || no_duplicate_coordinates? || !coordinates_not_empty?
      return false
    end
    if is_horizontal? && (user_coordinate_numbers.last - user_coordinate_numbers.first) + 1 == ship.length
      return true
    elsif is_vertical? && (user_coordinate_letters.last.ord - user_coordinate_letters.first.ord) + 1 == ship.length
      return true
    else
      return false
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.to_a.include? coordinate.to_sym
  end

#create a valid_length? helper method

  def coordinates_not_empty?
    @user_coordinates.each do |coordinate|
      if !@cells[coordinate.to_sym].empty?
        return false
      end
    end
  end

  def coordinates_match_ship_length?
    if @user_coordinates.count != @proposed_ship.length
      return false
    end
  end

  def no_duplicate_coordinates?
    if @user_coordinates.uniq.count != @user_coordinates.length
      return false
    end
  end

  def split_user_coordinates
    @user_coordinates.map do |coordinate|
      coordinate.split("")
    end
  end

  def user_coordinate_numbers
    split_user_coordinates.map do |sub_arr|
      sub_arr[1].to_i
    end.sort
  end

  def user_coordinate_letters
    split_user_coordinates.map do |sub_arr|
      sub_arr[0]
    end.sort
  end

  def is_horizontal?
    user_coordinate_letters.uniq.count == 1
  end

  def is_vertical?
    user_coordinate_numbers.uniq.count == 1
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
    # want to change each coordinate's ::ship
    # maybe using the cell's place_ship method?
    # This would be to update the status to "S"
    coordinates.each do |coordinate|
      @cells[coordinate.to_sym].place_ship(ship)
    end
  end

  def render(show_ships = false)
    count = 0
    array = []
    string = ""
    @cells.each do |key, cell|
      array << cell.status
    end
    board_dimension.times do
      string += "#{@cells.keys[count].to_s[0]} "
      board_dimension.times do
        string += "#{array[count]} "
        count += 1
      end
      string += "\n"
    end
    top_row + string
  end

  def top_row
    return "  #{board_numbers.join(' ')} \n"
  end

  def board_dimension
    Math.sqrt(@cells.count).to_i
  end

  # hash.each do |key, value|

  def board_numbers
    (1..board_dimension).to_a
  end
end
