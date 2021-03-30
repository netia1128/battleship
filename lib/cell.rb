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
end
