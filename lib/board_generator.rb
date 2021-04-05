require_relative 'cell'
require_relative 'board'

class BoardGenerator
  attr_reader :board_array,
              :board_hash

  def initialize(board_dimension)
    @board_dimension = board_dimension
    @board_array = []
    @board_hash = {}
  end

  def make_board_hash
    make_board_array
    board_array.each do |coordinate|
      board_hash[coordinate.to_sym] = Cell.new(coordinate)
    end
    board_hash
  end

  def make_board_array
    @board_array = []
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

## board = Board.new(board_hash, board_dimension)
## cell_hash = BoardGenerator.new(board_dimension)
