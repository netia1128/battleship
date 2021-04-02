require './lib/board_generator'

RSpec.describe BoardGenerator do

  describe '#initialize' do
    it 'creates an instance of a BoardGenerator' do
      board_generator = BoardGenerator.new(4)
      expect(board_generator).to be_an_instance_of(BoardGenerator)
    end
    it 'has an empty board array by default' do
      board_generator = BoardGenerator.new(7)
      expect(board_generator.board_array).to eq([])
    end
    it 'has an empty board hash by default' do
      board_generator = BoardGenerator.new(7)
      expect(board_generator.board_hash).to eq({})
    end
  end
  # describe '#make_board_hash' do
  #   it 'creates a hash of the generated board' do
  #     board_generator = BoardGenerator.new(7)
  #     board_generator.board_hash
  #     expect(board_generator.board_hash).to eq({})
  #   end
  # end
  describe '#make_board_array' do
    it 'creates an array of the generated board' do
      board_generator = BoardGenerator.new(3)
      board_generator.make_board_array
      expect(board_generator.board_array).to eq(["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"])
    end
  end
end
