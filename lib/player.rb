class Player

  def initialize(name, board_dimension)
    @name = name
    @board = Board.new(

    @crusier = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @tug_boat = Ship.new("Tug Boat", 1)
  end

end
