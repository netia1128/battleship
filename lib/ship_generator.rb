require_relative 'ship'

class ShipGenerator
  attr_reader :ships

  def initialize
    @ships = []
  end

  def make_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    tug_boat = Ship.new("Tug Boat", 1)
    @ships = [cruiser, submarine, tug_boat]
  end
end
