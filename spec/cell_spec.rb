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

    it 'has a coordinate' do
      expect(@cell.coordinate).to eq("B4")
    end

    it 'has a . status' do
      expect(@cell.status).to eq(".")
    end
  end
end
