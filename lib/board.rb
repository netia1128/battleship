require_relative 'evaluator'

class Board
  attr_reader :cells

  def initialize(board_dimension)
    @board_dimension = board_dimension
    @cells = make_board_hash
    @evaluator = Evaluator.new
  end

  def make_board_hash
    board_array = make_board_array
    board_hash = {}
    board_array.each do |coordinate|
      board_hash[coordinate.to_sym] = Cell.new(coordinate)
    end
    @cells = board_hash
  end

  def make_board_array
    board_array = []
    letters = ("A" .. "Z").to_a
    letter_count = 0
    number_count = 1
    # require 'pry'; binding.pry
    total_coordinates = @board_dimension * @board_dimension

    @board_dimension.times do
      @board_dimension.times do
        board_array << letters[letter_count] + (number_count).to_s
        number_count += 1
      end
      letter_count += 1
      number_count = 1
    end
    board_array
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
    if coordinate == nil
      return false
    else
      @cells.keys.to_a.include? coordinate.to_sym
    end
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
