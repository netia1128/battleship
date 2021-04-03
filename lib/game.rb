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
    puts "*********************************************************"
    puts "What is your name?"
    name = "Bob"
    # name = gets.chomp
    puts "Hi #{name}. " +
    "My name is Computron. I will be your computer opponent."
    puts "To start, we will create a square board to play with.\n" +
    "Your board can be anywhere between 4 and 9 cells wide.\n" +
    "How many cells would you like in each row?"
    # board_dimension = gets.chomp.to_i
    board_dimension = 4
    until ((4..9).to_a.include? board_dimension)
      puts "Sorry #{name} that is not a valid board size.\n" +
      "Please choose a board size between 4 and 9 cells wide."
      board_dimension = gets.chomp.to_i
    end
    puts "Great! we will start with a #{board_dimension}" +
    " by #{board_dimension} board."
    @player = Player.new(name, board_dimension)
    @computron = Player.new("Computron", board_dimension)
    ship_placement
    # require 'pry'; binding.pry
  end

  def ship_placement
    @computron.computron_placement
    puts "*********************************************************"
    puts "OK #{@player.name}, it's time to place ships.\n" +
    "We each have three ships.\n" +
    "The Cruiser, which is three cells long.\n" +
    "The Submarine, which is two cells long.\n" +
    "The Tug Boat, whic is one cell.\n" +
    "I have already placed my ships. Now it's your turn."
  end

end
