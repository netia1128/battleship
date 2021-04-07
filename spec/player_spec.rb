require './lib/player'

RSpec.describe Player do

  before do
    @player = Player.new({name: "Luka Modric", position: "midfielder"})
  end

  describe '::initialize' do
    it 'starts with a name' do
      expect(@player.name).to eq("Luka Modric")
    end
    it 'starts with a position' do
      expect(@player.position).to eq("midfielder")
    end
  end
end
