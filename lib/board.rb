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
    @player_provided_array = []
  end

  def valid_coordinate?(coordinate)
    @cells.keys.to_a.include? coordinate.to_sym
  end

  def valid_placement?(ship, array)

    @player_provided_array = array
    #check if ship length = array length
    if array.count != ship.length || array.uniq.count != array.length
      return false
    end

    @player_provided_array.each do |coordinate|
      if @cells[coordinate.to_sym].empty? == false
        return false
      end
    end

    split_player_coordinates
    if is_horizontal?
      if (create_array_of_numbers.sort.last - create_array_of_numbers.sort.first) + 1 == ship.length
        return true
      else
        return false
      end
    elsif is_vertical?
      if (create_array_of_letters.sort.last.ord - create_array_of_letters.sort.first.ord) + 1 == ship.length
        return true
      else
        return false
      end
    else
      return false
    end

  end

      def split_player_coordinates
        @player_provided_array.map do |coordinate|
          coordinate.split("")
        end
      end

      def create_array_of_numbers
        horizontal_arr = []
        split_player_coordinates.each do |sub_arr|
          horizontal_arr << sub_arr[1].to_i
        end
        return horizontal_arr
      end

      def create_array_of_letters
        vertical_arr = []
        split_player_coordinates.each do |sub_arr|
          vertical_arr << sub_arr[0]
        end
        return vertical_arr
      end

      def is_horizontal?
        create_array_of_letters.uniq.count == 1
      end

      def is_vertical?
        create_array_of_numbers.uniq.count == 1
      end

    end
    #  require "pry"; binding.pry
