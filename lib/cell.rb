class Cell
  attr_reader :coordinate,
              :status

  def initialize(coordinate)
    @coordinate = coordinate
    @status = "."
  end
end
