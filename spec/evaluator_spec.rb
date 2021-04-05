require './lib/evaluator'

RSpec.describe Evaluator do

  before do
    @evaluator = Evaluator.new(["A1", "A2"])
  end

  describe '#initialize' do
    it 'creates an instance of an Evaluator' do
      expect(@evaluator).to be_an_instance_of(Evaluator)
    end
    it 'starts with an array of coordinates' do
      expect(@evaluator.coordinates).to be_an_instance_of(Array)
    end
  end
end
