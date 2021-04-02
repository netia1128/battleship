require './lib/board_generator'

RSpec.describe BoardGenerator do

  describe '#initialize' do
    it 'creates an instance of a BoardGenerator' do
      board_generator = BoardGenerator.new(4)
      expect(board_generator).to be_an_instance_of(BoardGenerator)
    end
  end
end
