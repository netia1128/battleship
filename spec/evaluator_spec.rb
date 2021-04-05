require './lib/evaluator'

RSpec.describe Evaluator do

  describe '#initialize' do
    it 'creates an instance of an Evaluator' do
      evaluator = Evaluator.new
      expect(evaluator).to be_an_instance_of(Evaluator)
    end
  end
end
