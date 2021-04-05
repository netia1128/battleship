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

  def board_dimension_error
    "Sorry #{@name} that is not a valid board size.\n" +
    "Please choose a board size between 4 and 9 cells wide."
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
end
