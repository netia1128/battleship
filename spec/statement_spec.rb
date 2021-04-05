require './lib/statement'
require './lib/player'

RSpec.describe Statement do
  before do
    @statement = Statement.new
    @player = Player.new("Bob", 4)
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
  describe '#place_specific_ship' do
    it 'contains the place specific ship statement' do
      ship = Ship.new("Tug Boat", 1)
      expect(@statement.place_specific_ship).to eq("We are now placing the #{ship.name}.\n" +
      "The #{ship.name} is #{ship.length} cell(s) long.\n" +
      "Please provide #{ship.length} coordinate(s):")
    end
  end
  describe '#quit_game' do
    it 'contains the quit game statement' do
      expect(@statement.quit_game).to eq("Thanks for playing")
    end
  end
  describe '#ship_placement_explanation' do
    it 'contains the ship placement explanation statement' do
      expect(@statement.ship_placement_explanation).to eq("Great! Now let's place your ships.\n" +
      " \n" +
      "We each have three ships.\n" +
      "    -The Cruiser, which is three cells long.\n" +
      "    -The Submarine, which is two cells long.\n" +
      "    -The Tug Boat, which is one cell.\n" +
      " \n" +
      "I have already placed my ships. Now it's your turn. \n" +
      " \n" +
      "Let's start. Here is your board: \n" +
      " \n" +
      @player.board.render(true) +
      " \n" +
      "You will choose cells to put the ships in.\n" +
      "Please provide the coordinate of each cell" +
      " with just a space in between.\n" +
      "For example: \n" +
      "   A1 A2 A3\n" +
      " \n")
    end
  end
  describe '#ship_placement_success' do
    it 'contains the ship placement success statement' do
      ship = Ship.new("Tug Boat", 1)
      expect(@statement.quit_game).to eq(  "Great job #{@name}, you've placed your #{ship.name}!\n" +
        "Here is what your board looks like now.\n" +
        "S means there is a ship in a cell." +
        " \n" +
        @player.board.render(true) +
        " \n")
    end
  end
end
