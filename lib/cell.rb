class Cell
  attr_reader :coordinate,
              :status,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @status = "."
    @ship = nil
  end

  def empty?
    @status == "."
  end

  def place_ship(ship)
    @status = 'S'
    @ship = ship
  end

  def fired_upon?
    @status == "X" || @status == "M"
  end

  def fire_upon
    if @status == "."
      @status = "M"
    elsif @status == "S" && @ship.health > 1
      @status = "H"
    else
      @status = "X"
    end
  end
end
