require_relative 'player'

class Statement
  attr_reader :input,
              :name

  def initialize
    @input = ''
    @name = ''
  end

  def ask_board_dimension
    "To start, we will create a square board to play with.\n" +
    "Your board can be anywhere between 4 and 9 cells wide.\n" +
    "How many cells would you like in each row?"
  end

  def ask_name
    "What is your name?"
  end

  def battleship_graphic
    " _____     _____   _______  _______  _        _______  _______  _     _  _______  _____   \n" +
    "|  __  \\  /  _  \\ |__   __||__   __|| |      |  _____||  ____ || |   | ||__   __||  __  \\ \n" +
    "| |  \\  ||  / \\  |   | |      | |   | |      | |      | |   |_|| |   | |   | |   | |  \\  |\n" +
    "| |__/  || |___| |   | |      | |   | |      | |___   | |_____ | |___| |   | |   | |__/  |\n" +
    "|      / |  ___  |   | |      | |   | |      |  ___|  |______ ||  ___  |   | |   |  ____/ \n" +
    "|  __  \\ | |   | |   | |      | |   | |      | |            | || |   | |   | |   | |      \n" +
    "| |  \\  || |   | |   | |      | |   | |      | |       _    | || |   | |   | |   | |      \n" +
    "| |__/  || |   | |   | |      | |   | |_____ | |_____ | |___| || |   | | __| |__ | |      \n" +
    "|______/ |_|   |_|   |_|      |_|   |_______||_______||_______||_|   |_||_______||_|      " +
    " \n" +
    " \n"
  end

  def board_dimension_error
    "Sorry #{@name} that is not a valid board size.\n" +
    "Please choose a board size between 4 and 9 cells wide."
  end

  def computron_won
    "Computron won!"
  end

  def game_over
    "GAMEOVER!"
  end

  def get_name
    @name = gets.chomp
  end

  def get_user_input
    @input = gets.chomp.upcase
  end

  def introduction
    "Hi #{@name}. \n" +
    "My name is Computron. I will be your opponent."
  end

  def main_menu
    "Welcome to Battleship! \n" +
    "Enter P to play or Q to quit"
  end

  def print_to_terminal(statement)
    puts statement
  end

  def quit_game
    "Thanks for playing"
  end

  def place_specific_ship(ship)
    "We are now placing the #{ship.name}.\n" +
    "The #{ship.name} is #{ship.length} cell(s) long.\n" +
    "Please provide #{ship.length} coordinate(s):"
  end

  def ship_placement_error(player, ship)
     "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n" +
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
    "Please provide #{ship.length} coordinate(s):"
  end

  def ship_placement_explanation(player)
    "Great! Now let's place your ships.\n" +
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
    player.board.render(true) +
    " \n" +
    "You will choose cells to put the ships in.\n" +
    "Please provide the coordinate of each cell" +
    " with just a space in between.\n" +
    "For example: \n" +
    "   A1 A2 A3\n" +
    " \n"
  end

  def ship_placement_success(ship, player)
    "Great job #{@name}, you've placed your #{ship.name}!\n" +
    "Here is what your board looks like now.\n" +
    "S means there is a ship in a cell." +
    " \n" +
    player.board.render(true) +
    " \n"
  end

  def shot_report(player, computron, shot_coordinate)
    case computron.board.cells[shot_coordinate.to_sym].status
    when "M"
      "You missed!"
    when "H"
       "You hit something!"
    when "X"
       "You sunk a ship!"
    end +
     " \n" +
    case player.board.cells[player.last_shot_coordinate.to_sym].status
    when "M"
       "Then Computron took a shot and missed!"
    when "H"
       "Then Computron took a shot and hit something!"
    when "X"
       "Then Computron took a shot and sunk a ship!"
    end +
     " \n" +
     "Time for the next turn!" +
     " \n"
  end

  def take_turn(player, computron)
    " \n" +
    "=============COMPUTRON BOARD============= \n" +
    " \n" +
    computron.board.render +
    " \n" +
    "==============PLAYER BOARD============== \n" +
    " \n" +
    player.board.render(true) +
    " \n" +
    "Please pick a coordinate on Computron's board to fire upon:\n"
  end

  def take_turn_error(player, computron)
    "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" +
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
    "Please try again.\n"
  end

  def turn_explanation
    "Great work, all your ships have been placed. \n" +
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
    "Now let's play"
  end

  def you_won
    "You won!"
  end
end
