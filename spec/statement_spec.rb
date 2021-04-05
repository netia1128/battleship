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
    it 'starts with an empty name' do
      expect(@statement.name).to eq('')
    end
  end
  describe '#ask_board_dimension' do
    it 'contains the ask board board_dimension statement' do
      expect(@statement.ask_board_dimension).to eq("To start, we will create a square board to play with.\n" +
      "Your board can be anywhere between 4 and 9 cells wide.\n" +
      "How many cells would you like in each row?")
    end
  end
  describe '#ask_name' do
    it 'contains the ask name statement' do
      expect(@statement.ask_name).to eq("What is your name?")
    end
  end
  describe '#board_dimension_error' do
    it 'contains the board_dimension_error statement' do
      expect(@statement.board_dimension_error).to eq("Sorry #{@name} that is not a valid board size.\n" +
      "Please choose a board size between 4 and 9 cells wide.")
    end
  end
  describe '#introduction' do
    it 'contains the introduction statement' do
      expect(@statement.introduction).to eq("Hi #{@statement.name}. \n" +
      "My name is Computron. I will be your opponent.")
    end
  end
  describe '#main_menu' do
    it 'contains the main menu statement' do
      expect(@statement.main_menu).to eq("Welcome to Battleship! \n" +
      "Enter P to play or Q to quit")
    end
  end
  describe '#quit_game' do
    it 'contains the quit game statement' do
      expect(@statement.quit_game).to eq("Thanks for playing")
    end
  end

end
