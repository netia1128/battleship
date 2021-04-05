require './lib/evaluator'
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
    it 'creates an instance of a Board' do
      expect(@computron.board).to be_an_instance_of(Board)
    end
    it 'creates three ships' do
      expect(@computron.ships.count).to eq(3)
    end
  end
  describe '#try' do
    it 'returns a proposed array the same size as the given ship' do
      expect(@computron.try(@computron.ships[0]).count).to eq(3)
    end
  end
  describe '#computron_placement' do
    it 'by default chages the status of 6 cells to S' do
      @computron.computron_ship_placement
      count_of_s = @computron.board.cells.find_all do |key, cell|
                    cell.status == 'S'
                   end.count
      expect(count_of_s).to eq(6)
    end
  end
  describe '#fire_upon' do
    it 'returns false if player fires upon an invalid coordinate' do
      expect(@computron.fire_upon("A0")).to eq(false)
    end
    it 'returns false if player fires upon an already fired upon cell' do
      @computron.fire_upon("A1")
      expect(@computron.fire_upon("A1")).to eq(false)
    end
  end
  describe '#auto_shot_selection' do
    it 'populates last_shot_coordinate' do
      @player.auto_shot_selection
      expect(@player.last_shot_coordinate.length).to eq(2)
    end
  end
end
