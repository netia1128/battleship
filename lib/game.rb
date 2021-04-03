require_relative 'player'

class Game
  attr_reader :player
              :computron

  def initialize
    @player = ""
    @computron = ""
  end

  def main_menu_statement
    puts "Welcome to Battleship!"
    puts "Enter P to play or Q to quit"
    input = gets.chomp.upcase
    if input == "P"
      player_information
    elsif input == "Q"
      quit_game
    else
      main_menu_statement
    end
  end

  def quit_game
    puts "Thanks for playing"
  end

  def player_information
    puts "*******************"
    puts "What is your name?"
    name = gets.chomp
    puts "Hi #{name}. " +
    "My name is Computron. I will be your computer opponent."
    puts "To start, we will create a square board to play with.\n" +
    "Your board can be anywhere between 4 and 9 cells wide.\n" +
    "How many cells would you like in each row?"
    board_dimension = gets.chomp.to_i
    until ((4..9).to_a.include? board_dimension)
      puts "Sorry #{name} that is not a valid board size.\n" +
      "Please choose a board size between 4 and 9 cells wide."
      board_dimension = gets.chomp.to_i
    end
    puts "Great! we will start with a #{board_dimension}" +
    " by #{board_dimension} board."
    @player = Player.new(name, board_dimension)
    @computron = Player.new("Computron", board_dimension)
    computron_placement
    # require 'pry'; binding.pry
  end

  def computron_placement
    @computron.computron_placement
  end

end
