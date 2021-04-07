require './lib/statement'
require './lib/player'

RSpec.describe Statement do
  before do
    @statement = Statement.new
    @player = Player.new(4)
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
  describe '#ask_difficulty_level' do
    it 'contains the ask ask difficulty level statement' do
      expect(@statement.ask_difficulty_level).to eq("What level of difficulty would you like to play? \n" + "Please select 'hard', or 'easy'?")
    end
  end
  describe '#ask_name' do
    it 'contains the ask name statement' do
      expect(@statement.ask_name).to eq("What is your name?")
    end
  end
  describe '#battleship_graphic' do
    it 'contains the battleship graphic' do
      expect(@statement.battleship_graphic).to eq(  " _____     _____   _______  _______  _        _______  _______  _     _  _______  _____   \n" +
        "|  __  \\  /  _  \\ |__   __||__   __|| |      |  _____||  ____ || |   | ||__   __||  __  \\ \n" +
        "| |  \\  ||  / \\  |   | |      | |   | |      | |      | |   |_|| |   | |   | |   | |  \\  |\n" +
        "| |__/  || |___| |   | |      | |   | |      | |___   | |_____ | |___| |   | |   | |__/  |\n" +
        "|      / |  ___  |   | |      | |   | |      |  ___|  |______ ||  ___  |   | |   |  ____/ \n" +
        "|  __  \\ | |   | |   | |      | |   | |      | |            | || |   | |   | |   | |      \n" +
        "| |  \\  || |   | |   | |      | |   | |      | |       _    | || |   | |   | |   | |      \n" +
        "| |__/  || |   | |   | |      | |   | |_____ | |_____ | |___| || |   | | __| |__ | |      \n" +
        "|______/ |_|   |_|   |_|      |_|   |_______||_______||_______||_|   |_||_______||_|      " +
        " \n" +
        " \n")
    end
  end
  describe '#board_dimension_error' do
    it 'contains the board_dimension_error statement' do
      expect(@statement.board_dimension_error).to eq("Sorry #{@name} that is not a valid board size.\n" +
      "Please choose a board size between 4 and 9 cells wide.")
    end
  end
  describe '#computron_won' do
    it 'contains the board_dimension_error statement' do
      expect(@statement.computron_won).to eq(  "Computron sunk all of your ships! \n" +
        "Computron won!")
    end
  end
  describe '#difficulty_level_error' do
    it 'contains the difficulty level error statement' do
      expect(@statement.difficulty_level_error).to eq(     "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n" +
           " \n" +
           "I'm sorry #{@name}, that is not a valid option. \n" +
           "Please select either 'easy' or 'hard'. \n" +
           " \n" +
           "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n")
    end
  end
  describe '#game_over' do
    it 'contains the board_dimension_error statement' do
      expect(@statement.game_over).to eq("GAMEOVER!")
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
      expect(@statement.place_specific_ship(ship)).to eq("We are now placing the #{ship.name}.\n" +
      "The #{ship.name} is #{ship.length} cell(s) long.\n" +
      "Please provide #{ship.length} coordinate(s):")
    end
  end
  describe '#quit_game' do
    it 'contains the quit game statement' do
      expect(@statement.quit_game).to eq("Thanks for playing")
    end
  end
  describe '#ship_placement_error' do
    ship = Ship.new("Tug Boat", 1)
    player = Player.new(4)
    it 'contains the ship placement error statement' do
      expect(@statement.ship_placement_error(player, ship)).to eq(   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n" +
        " \n" +
        "Sorry #{@name}, your placement is not valid.\n" +
        "For a valid placement each of the following must be true:\n" +
        "- Please provide a number of coordinates equal to the ship length\n" +
        "- The coordinates must be consecuitive\n" +
        "- The coordinates must run horizontally or vertically\n" +
        "- You cannot already have a ship in a proposed coordinate\n" +
        "- You must enter each coordinate with just a space in between.\n" +
        "      For example:\n" +
        "      A1 A2 A3 \n" +
        " \n" +
         "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n" +
        " \n" +
        "Please try again. Here is your board: \n" +
        " \n" +
        player.board.render(true) +
        " \n" +
        "Please provide #{ship.length} coordinate(s):")
    end
  end
  describe '#ship_placement_explanation' do
    it 'contains the ship placement explanation statement' do
      expect(@statement.ship_placement_explanation(@player)).to eq("Great! Now let's place your ships.\n" +
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
      expect(@statement.ship_placement_success(ship, @player)).to eq("Great job #{@name}, you've placed your #{ship.name}!\n" +
      "Here is what your board looks like now.\n" +
      "S means there is a ship in a cell. \n" +
      " \n" +
      @player.board.render(true) +
      " \n")
    end
  end
  describe '#ship_placement_success' do
    it 'contains the ship placement success statement' do
      ship = Ship.new("Tug Boat", 1)
      expect(@statement.ship_placement_success(ship, @player)).to eq(    "Great job #{@name}, you've placed your #{ship.name}!\n" +
          "Here is what your board looks like now.\n" +
          "S means there is a ship in a cell. \n" +
          " \n" +
          @player.board.render(true) +
          " \n")
    end
  end
  describe '#take_turn' do
    it 'contains the take turn statement' do
      player = Player.new(4)
      computron = Player.new(4)
      expect(@statement.take_turn(player, computron)).to eq(    " \n" +
          "=============COMPUTRON BOARD============= \n" +
          " \n" +
          computron.board.render +
          " \n" +
          "==============PLAYER BOARD============== \n" +
          " \n" +
          player.board.render(true) +
          " \n" +
          "Please pick a coordinate on Computron's board to fire upon:\n")
    end
    describe '#take_turn_error' do
      it 'contains the take turn error statement' do
        player = Player.new(4)
        computron = Player.new(4)
        expect(@statement.take_turn_error(player, computron)).to eq(        "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" +
            " \n" +
            "\nSorry #{@name} " +
            "Your shot coordinate is not valid.\n" +
            "To have a valid shot placement all of the following must be true:\n" +
            "- The coordinate must be on the board.\n" +
            "- You cannot already have fired upon the coordinate.\n" +
            "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n" +
            "\n" +
            '=============COMPUTRON BOARD=============' +
            " \n" +
            computron.board.render +
            " \n" +
            '==============PLAYER BOARD==============' +
            " \n" +
            player.board.render(true) +
            " \n" +
            "Please try again.\n")
      end
    end
  end
  describe '#turn_explanation' do
    it 'contains the turn explanation statement' do
      expect(@statement.turn_explanation).to eq("Great work, all your ships have been placed. \n" +
        "Let me quickly explain how to play. \n" +
        " \n" +
        "To play you will choose a cell on my board to fire upon.\n" +
        "To do this, provide the coordinate of the cell you wish to fire upon.\n" +
        "For example: A1\n" +
        "When you are done, I will fire upon your board.\n" +
        " \n" +
        "After we each take our turn, I will summarize what happened and update " +
        "the board as follows: \n" +
        "  - . represents a cell that has not been fired on yet\n" +
        "  - S represents your ships (we cannot see each others ships)\n" +
        "  - M represents a miss\n" +
        "  - H represents a hit\n" +
        "  - X represents a sunk ship \n" +
        " \n" +
        "We will take turns until all of someone's ships have been sunk.\n" +
        " \n" +
        "Now let's play")
      end
    end
    describe '#you_won' do
      it 'contains the you won statement' do
        expect(@statement.you_won).to eq("You sunk all of Computron's ships! \n" +
        "You won!")
      end
    end
end
