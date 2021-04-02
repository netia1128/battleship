require './lib/board_generator'
require './lib/cell'

board = BoardGenerator.new(5)
puts board.make_board_hash.keys
