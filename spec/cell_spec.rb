require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before do
    @cell = Cell.new("B4")
  end

  describe '#initialize' do
    it 'creates an instance of a cell' do
      expect(@cell).to be_an_instance_of(Cell)
    end
  end
end
