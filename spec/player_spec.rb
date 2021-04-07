require './lib/evaluator'
require './lib/player'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/ship_generator'


RSpec.describe Player do

  before do
    @player = Player.new(4)
    @computron = Player.new(4)
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
  describe '#attempt_auto_ship_placement' do
    it 'returns a proposed array the same size as the given ship' do
      expect(@computron.attempt_auto_ship_placement(@computron.ships[0]).count).to eq(3)
    end
  end
  describe '#auto_ship_placement' do
    it 'by default chages the status of 6 cells to S' do
      @computron.auto_ship_placement
      count_of_s = @computron.board.cells.find_all do |key, cell|
        cell.status == 'S'
      end.count
      expect(count_of_s).to eq(6)
    end
  end
  describe '#auto_shot_selection' do
    it 'results in a shot being taken' do
      @player.auto_shot_selection
      expect(@player.last_shot_coordinate.length).to eq(2)
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
  describe '#random_shot' do
    it 'results in a shot being taken' do
      @player.random_shot
      expect(@player.shots_available.count).to eq(15)
    end
  end
  describe '#set_direction' do
    it 'choses an element from the movement array' do
      evaluator = Evaluator.new(@player.board.cells)
      movement_array = [1]
      expect(@player.set_direction(movement_array)).to eq(1)
    end
  end
  describe '#set_pivot_point_index' do
    it 'returns the index of a pivot point cell in the cells array' do
      expect(@player.set_pivot_point_index("A3")).to eq(2)
    end
  end
  describe '#set_random_pivot_point' do
    it 'chooses a random cell that has not been fired on' do
      bob = Player.new(2)
      bob.fire_upon("A1")
      bob.fire_upon("A2")
      bob.fire_upon("B1")
      expect(bob.set_random_pivot_point).to eq("B2")
    end
  end
  describe '#smart_shot' do
    it 'fires upon cells in a logical order' do
      bob = Player.new(2)
      submarine = Ship.new("submarine", 2)
      bob.board.place(["A1", "A2"], submarine)
      bob.fire_upon("A1")
      bob.fire_upon("B1")
      expect(bob.smart_shot(["A1"])).to eq("A2")
    end
  end
end
