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
end
