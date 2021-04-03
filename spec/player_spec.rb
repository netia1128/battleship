require './lib/board_generator'
require './lib/player'
require './lib/board'
require './lib/ship'


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

end
