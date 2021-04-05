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
    @status == "X" || @status == "M" || @status == "H"
  end

  def fire_upon
    if self.fired_upon?
      return false
    end
    if @status == "."
      @status = "M"
    elsif @status == "S" && @ship.health > 1
      @ship.hit
      @status = "H"
    else
      @ship.hit
      @status = "X"
    end
  end

  def render(show_ships = false)
    if show_ships == false && @status == "S"
      "."
    elsif !@ship.nil? && @ship.sunk?
      "X"
    else
      @status
    end
  end
end
