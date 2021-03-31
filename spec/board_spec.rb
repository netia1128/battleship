require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @tug_boat = Ship.new("Tug Boat", 1)
  end

  describe '#initialize' do
    it 'creates an instance of a board' do
      expect(@board).to be_an_instance_of(Board)
    end
  end
end
