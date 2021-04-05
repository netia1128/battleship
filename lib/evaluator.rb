require_relative 'board'

class Evaluator

  def is_consecutive?(coordinates, ship)
    if is_horizontal?(coordinates)
      return ((user_coordinate_numbers(coordinates).last - user_coordinate_numbers(coordinates).first) + 1 == ship.length)
    elsif is_vertical?(coordinates)
      return ((user_coordinate_letters(coordinates).last.ord - user_coordinate_letters(coordinates).first.ord) + 1 == ship.length)
    else
      return false
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

  def is_horizontal_or_vertical?(coordinates)
    user_coordinate_letters(coordinates).uniq.count == 1 || user_coordinate_numbers(coordinates).uniq.count == 1
  end

end
