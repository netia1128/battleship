require './lib/board_generator'
require './lib/player'
require './lib/board'
require './lib/ship'
require './lib/cell'


RSpec.describe Player do

  before do
    @player = Player.new("Brant", 4)
    @computron = Player.new("Computron", 4)
  end

  describe '#initialize' do
    it 'creates an instance of a Player' do
      expect(@computron).to be_an_instance_of(Player)
    end
    it 'creates an instance of a Board Generator' do
      expect(@computron.board_generator).to be_an_instance_of(BoardGenerator)
    end
    it 'creates an instance of a Board' do
      expect(@computron.board).to be_an_instance_of(Board)
    end
    it 'creates three ships' do
      expect(@computron.ships.count).to eq(3)
    end
  end
  describe '#try' do
    it 'returns a proposed array the same size as the given ship' do
      destroyer = Ship.new("Destroyer", 4)
      expect(@computron.try(destroyer).count).to eq(4)
    end
  end
  describe '#computron_placement' do
    it 'by default chages the status of 6 cells to S' do
      @computron.computron_placement
      count_of_s = @computron.board.cells.find_all do |key, cell|
                    cell.status == 'S'
                   end.count
      expect(count_of_s).to eq(6)
    end
  end
end
