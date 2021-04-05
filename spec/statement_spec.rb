require './lib/statement'

RSpec.describe Statement do
  before do
    @statement = Statement.new
  end

  describe '#initialize' do
    it 'creates an instance of a statement' do
      expect(@statement).to be_an_instance_of(Statement)
    end
  end

end
