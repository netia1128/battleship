require './lib/statement'

RSpec.describe Statement do
  before do
    @statement = Statement.new
  end

  describe '#initialize' do
    it 'creates an instance of a statement' do
      expect(@statement).to be_an_instance_of(Statement)
    end
    it 'starts with an empty input' do
      expect(@statement.input).to eq('')
    end
  end

  describe '#main_menu_statement' do
    it 'contains the main menu statement' do
      expect(@statement.main_menu_statement).to eq("Welcome to Battleship! \n" +
      "Enter P to play or Q to quit")
    end
  end

end
