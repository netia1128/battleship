class Statement
  attr_reader :input,
              :name

  def initialize
    @input = ''
    @name = ''
  end

  def ask_name
    "What is your name?"
  end

  def get_user_input
    @input = gets.chomp.upcase
  end

  def introduction
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
