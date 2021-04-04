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
    ship_placement_statement
    # require 'pry'; binding.pry
  end

  def ship_placement_statement
    @computron.computron_placement
    puts "*********************************************************"
    puts "OK #{@player.name}, it's time to place ships.\n" +
    "We each have three ships.\n" +
    "The Cruiser, which is three cells long.\n" +
    "The Submarine, which is two cells long.\n" +
    "The Tug Boat, whic is one cell.\n" +
    "I have already placed my ships. Now it's your turn."
    ship_placement
  end

  def ship_placement
    puts "*********************************************************"
    puts "Let's start. Here is your board: \n"
    puts @player.board.render(true)
    puts "You will choose cells to put the ships in.\n" +
    "Please provide the coordinate of each cell" +
    " with just a space in between.\n" +
    "For example: A1 A2 A3\n" +
    "\n"
    # @player.ships.each do |ship|
    #   puts "We are now placing the #{ship.name}.\n" +
    #   "The #{ship.name} is #{ship.length} cells long.\n" +
    #   "Please provide #{ship.length} cells:"
    #   ship_placement_evaluation(ship)
    #   puts @player.board.render(true)
    # end
    @player.computron_placement
    take_turn_statement
  end

def ship_placement_evaluation(ship)
  user_coordinates = gets.chomp.upcase.split(" ")
  until (@player.board.place(user_coordinates, ship)) != false
    puts "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    puts "\nSorry #{@player.name} " +
    "Your placement is not valid.\n" +
    "To have a valid placement all of the following must be true:\n" +
    "- Please provide number of coordinates equal to ship length\n" +
    "- Your coordinates must be consecuitive\n" +
    "- Your coordinates must run horizontally or vertically\n" +
    "- You cannot already have a ship in a proposed coordinate\n" +
    "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n" +
    "\n" +
    "Please try again.\n"
    puts @player.board.render(true)
    user_coordinates = gets.chomp.upcase.split(" ")
  end
  @player.board.place(user_coordinates, @player.ships[0])
  puts ""
end

def take_turn_statement
  system 'clear'
  puts 'Now let\'s play the game.'
  # puts '=============COMPUTER BOARD============='
  # puts @computron.board.render
  # puts '==============PLAYER BOARD=============='
  # puts @player.board.render(true)
  puts "You will choose a cell on my board to fire upon.\n" +
  "We will take turns until all of someone\'s ships have been sunk.\n" +
  "For each turn provide the coordinate of the cell you wish to fire upon.\n" +
  "For example: A1\n" +
  "\n"
  take_turn
  end

  def take_turn
    until end_of_game?
      puts ''
      puts '=============COMPUTER BOARD============='
      puts @computron.board.render
      puts ''
      puts '==============PLAYER BOARD=============='
      puts @player.board.render(true)
      puts ''
      puts "Please pick your coordinate.\n"
      take_turn_evaluation
    end
    end_of_game_statement
  end

  def take_turn_evaluation
    shot_coordinate = gets.chomp.upcase
    until @computron.fire_upon(shot_coordinate) != false
      system 'clear'
      puts "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      puts "\nSorry #{@player.name} " +
      "Your shot coordinate is not valid.\n" +
      "To have a valid shot placement all of the following must be true:\n" +
      "- Your coordinate must be on the board.\n" +
      "- You cannot already have fired upon your proposed coordinate\n" +
      "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n" +
      "\n"
      puts '=============COMPUTER BOARD============='
      puts @computron.board.render
      puts '==============PLAYER BOARD=============='
      puts @player.board.render(true)
      puts "Please try again.\n"
      shot_coordinate = gets.chomp.upcase
    end
    @computron.fire_upon(shot_coordinate)
    @player.auto_shot_selection
    system 'clear'
    puts ''
    shot_statement(shot_coordinate)
    # evaluation of shot placement
    # invalid shot statment
  end

  def shot_statement(shot_coordinate)
    case @computron.board.cells[shot_coordinate.to_sym].status
    when "M"
      puts "You missed!"
    when "H"
      puts "You hit something!"
    when "X"
      puts "You sunk a ship!"
    end
    puts ''
    case @player.board.cells[@player.last_shot_coordinate.to_sym].status
    when "M"
      puts "The computer took a shot and missed!"
    when "H"
      puts "The computer took a shot and hit something!"
    when "X"
      puts "The computer took a shot and sunk a ship!"
    end
    puts ' '
    puts 'Time for the next turn!'
    puts ''
  end



  def end_of_game_statement
    puts "GAME OVER"
  end

  def end_of_game?
    @player.ships.all? do |ship|
      ship.sunk?
    end ||
    @computron.ships.all? do |ship|
      ship.sunk?
    end
  end
end
