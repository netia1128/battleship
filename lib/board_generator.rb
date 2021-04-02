class BoardGenerator
  attr_reader :board_array

  def initialize(board_dimension)
    #pass in board dimensions and create hash of cells for the board
    @board_dimension = board_dimension
    @board_array = []
  end

  def make_board_hash
    make_board_array
    board_hash = Hash.new
    board_array.each do |coordinate|
      board_hash[coordinate.to_sym] = Cell.new(coordinate)
    end
    board_hash
  end

  def make_board_array
    letters = ("A" .. "Z").to_a
    letter_count = 0
    number_count = 1
    total_coordinates = @board_dimension * @board_dimension

    @board_dimension.times do
      @board_dimension.times do
        @board_array << letters[letter_count] + (number_count).to_s
        number_count += 1
      end
      letter_count += 1
      number_count = 1
    end
  end
end