class Statement
  attr_reader :input

  def initialize
    @input = ''
  end

  def get_user_input
    @input = gets.chomp.upcase
  end

  def main_menu_statement
    "Welcome to Battleship! \n" +
    "Enter P to play or Q to quit"
  end

  def print_to_terminal(statement)
    puts statement
  end

  def quit_game_statement
    "Thanks for playing"
  end
end
